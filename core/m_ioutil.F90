!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !MODULE: m_ioutil - a F90 module for several convenient I/O functions
!
! !DESCRIPTION:
!
!       m\_ioutil is a module containing several portable interfaces for
!       some highly system dependent, but frequently used I/O functions.
!
! !INTERFACE:

module m_ioutil
  implicit none
  private ! except

  public  :: opntext,clstext ! open/close a text file
  public  :: opnieee,clsieee ! open/close a binary sequential file
  public  :: luavail         ! return a free logical unit
  public  :: luflush         ! flush the buffer of a given unit
  !public :: MX_LU

  public  :: stdin         ! a unit linked to UNIX stdin
  public  :: stdout ! a unit linked to UNIX stdout
  public  :: stderr ! a unit linked to UNIX stderr


  ! !REVISION HISTORY:
  !       16Jul96 - J. Guo        - (to do)
  !       02Apr97 - Jing Guo <guo@eramus> - finished the coding
  !       11Feb97 - Jing Guo <guo@thunder> - added luflush()
  !EOP
  !_______________________________________________________________________

  !    Defines standar i/o units.

  integer, parameter :: stdin  = 5
  integer, parameter :: stdout = 6
#ifdef sysHPUX
  ! Special setting for HP-UX

  integer, parameter :: stderr = 7
#else
  ! Generic setting for UNIX other than HP-UX

  integer, parameter :: stderr =  0
#endif


  character(len=*),parameter :: myname="m_ioutil"
  integer,parameter :: MX_LU=255

contains

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !-----------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: opnieee - portablly open an IEEE format file
  !
  ! !DESCRIPTION:
  !
  !       Open a file in `IEEE' format.
  !
  !       `IEEE' format is refered as a FORTRAN "unformatted" file with
  !       "sequantial" access and variable record lengths.  Under common
  !       Unix, it is only a file with records packed with a leading 4-
  !       byte word and a trailing 4-byte word indicating the size of
  !       the record in bytes.  However, under UNICOS, it is also assumed
  !       to have numerical data representations represented according to
  !       the IEEE standard corresponding KIND conversions.  Under a DEC
  !       machine, it means that compilations of the source code should
  !       have the "-bigendian" option specified.
  !
  ! !INTERFACE:

  subroutine opnieee(lu,fname,status,ier)

    integer,         intent(in) :: lu     ! logical unit number
    character(len=*),intent(in) :: fname  ! filename to be opended
    character(len=*),intent(in) :: status ! the value for STATUS=
    integer,         intent(out):: ier    ! the status

    ! !REVISION HISTORY:
    !       02Feb95 - Jing G. - First version included in PSAS.  It is not
    !               used in the libpsas.a calls, since no binary data input/
    !               output is to be handled.
    !
    !       09Oct96 - J. Guo  - Check for any previous assign() call under
    !               UNICOS.
    !  15May20 - J. G. de Mattos - standardized open statement to open
    !                              with stream I/O a more flexible way
    !                            - add a read statement based on stream
    !                              I/O
    !EOP
    !_______________________________________________________________________

    ! local parameter
    character(len=*),parameter :: myname_=myname//'::opnieee'

    integer,parameter :: iA=ichar('a')
    integer,parameter :: mA=ichar('A')
    integer,parameter :: iZ=ichar('z')

    logical :: direct
    character(len=16) :: clen
    character(len=len(status)) :: Ustat
    integer :: i,ic

    direct = .false.
#ifdef _UNICOS
    character(len=128) :: attr

    call asnqunit(lu,attr,ier)      ! test the unit

    if(ier.eq.-1) then              ! the unit is not used
       if(direct) then
          call asnunit(lu,'-N ieee -F null',ier)
       else
          call asnunit(lu,'-N ieee -F f77',ier)
       endif
       ier=0

    elseif(ier.ge.0) then           ! the unit is already assigned
       ier=-1
    endif
    if(ier.ne.0) return
#endif

    do i=1,len(status)
       ic=ichar(status(i:i))
       if(ic >= iA .and. ic <= iZ) ic=ic+(mA-iA)
       Ustat(i:i)=char(ic)
    end do

    select case(Ustat)

    case ('APPEND')

       open(                         &
            unit            = lu,          &
            file            = fname,             &
            form            ='unformatted',&
            status       ='unknown',     &
            position ='append',     &
            access   = 'stream',    &
            iostat       = ier )

    case default

       open(                      &
            unit         = lu,           &
            file         = fname,        &
            form         = 'unformatted',&
            status    = status,       &
            position  = 'asis',       &
            access   = 'stream',     &
            iostat    = ier           )


    end select

  end subroutine opnieee
  !-----------------------------------------------------------------------
  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !-----------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: clsieee - Close a logical unit opened by opnieee()
  !
  ! !DESCRIPTION:
  !
  !       The reason for a paired clsieee() for opnieee() instead of a
  !       simple close(), is for the portability reason.  For example,
  !       under UNICOS, special system calls may be need to set up the
  !       unit right, and the status of the unit should be restored upon
  !       close.
  !
  ! !INTERFACE:

  subroutine clsieee(lu,ier,status)
    integer,                    intent(in)  :: lu    ! the unit used by opnieee()
    integer,                    intent(out) :: ier           ! the status
    Character(len=*), optional, intent(In)  :: status ! keep/delete

    ! !REVISION HISTORY:
    !       10Oct96 - J. Guo        - (to do)
    !EOP
    !_______________________________________________________________________
    character(len=*), parameter :: myname_ = myname//'::clsieee'
    Character(Len=6) :: status_

    status_ = 'KEEP'
    If (Present(status)) Then
       Select Case (Trim(status))
       Case ('DELETE','delete')
          status_ = 'DELETE'
       Case  ('KEEP','keep')
          status_ = 'KEEP'
       Case Default
          ier = -997
          return
       End Select
    End If

    close(lu,iostat=ier,status=status_)
#ifdef _UNICOS
    if(ier==0) call asnunit(lu,'-R',ier) ! remove attributes
#endif

  end subroutine clsieee

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !-----------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: opntext - portablly open a text file
  !
  ! !DESCRIPTION:
  !
  !       Open a text (ASCII) file.  Under FORTRAN, it is defined as
  !       "formatted" with "sequential" access.
  !
  ! !INTERFACE:

  subroutine opntext(lu,fname,status,ier)

    integer,         intent(in) :: lu     ! logical unit number
    character(len=*),intent(in) :: fname  ! filename to be opended
    character(len=*),intent(in) :: status ! the value for STATUS=<>
    integer,         intent(out):: ier    ! the status


    ! !REVISION HISTORY:
    !
    !       02Feb95 - Jing G. - First version included in PSAS and libpsas.a
    !       09Oct96 - J. Guo  - modified to allow assign() call under UNICOS
    !                         = and now, it is a module in Fortran 90.
    !EOP
    !_______________________________________________________________________

    ! local parameter
    character(len=*),parameter :: myname_=myname//'::opntext'

    integer,parameter :: iA=ichar('a')
    integer,parameter :: mA=ichar('A')
    integer,parameter :: iZ=ichar('z')

    character(len=len(status)) :: Ustat
    integer :: i,ic

#ifdef _UNICOS
    call asnunit(lu,'-R',ier)       ! remove any set attributes
    if(ier.ne.0) return             ! let the parent handle it
#endif

    do i=1,len(status)
       ic=ichar(status(i:i))
       if(ic >= iA .and. ic <= iZ) ic=ic+(mA-iA)
       Ustat(i:i)=char(ic)
    end do

    select case(Ustat)

    case ('APPEND')

       open(                         &
            unit        =lu,            &
            file        =fname,         &
            form        ='formatted',   &
            access      ='sequential',  &
            status      ='unknown',     &
            position    ='append',      &
            iostat      =ier            )

    case default

       open(                         &
            unit        =lu,            &
            file        =fname,         &
            form        ='formatted',   &
            access      ='sequential',  &
            status      =status,        &
            position    ='asis',        &
            iostat      =ier            )

    end select

  end subroutine opntext

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !-----------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: clstext - close a text file opend with an opntext() call
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  subroutine clstext(lu,ier,status)

    integer,                    intent(in)  :: lu     ! a logical unit to close
    integer,                    intent(out) :: ier    ! the status
    Character(len=*), optional, intent(In)  :: status ! keep/delete

    ! !REVISION HISTORY:
    !       09Oct96 - J. Guo        - (to do)
    !EOP
    !_______________________________________________________________________
    character(len=*), parameter :: myname_ = myname//'::clsitext'
    Character(Len=6) :: status_

    status_ = 'KEEP'
    If (Present(status)) Then
       Select Case (Trim(status))
       Case ('DELETE','delete')
          status_ = 'DELETE'
       Case  ('KEEP','keep')
          status_ = 'KEEP'
       Case Default
          ier = -997
          return
       End Select
    End If

    close(lu,iostat=ier,status=status_)
#ifdef _UNICOS
    if(ier == 0) call asnunit(lu,'-R',ier)  ! remove any attributes
#endif

  end subroutine clstext

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !BOP -------------------------------------------------------------------
  !
  ! !IROUTINE: luavail - locate the next available unit
  !
  ! !DESCRIPTION:
  !
  !    luavail() Look for an available (not opened and not statically
  !    assigned to any I/O attributes to) logical unit.
  !
  ! !INTERFACE:

  function luavail()
    integer :: luavail    ! result

    ! !REVISION HISTORY:
    !       23Apr98 - Jing Guo <guo@thunder> - new prototype/prolog/code
    !                       - with additional unit constraints for SunOS.
    !
    !       : Jing Guo, [09-Oct-96]
    !               + Checking also Cray assign() attributes, with some
    !                 changes to the code.  See also other routines.
    !
    !       : Jing Guo, [01-Apr-94]
    !               + Initial code.
    !EOP ___________________________________________________________________

    character(len=*),parameter :: myname_=myname//'::luavail'

    integer lu,ios
    logical inuse
    character*8 attr

    lu=-1
    ios=0
    inuse=.true.

    do while(ios.eq.0.and.inuse)
       lu=lu+1

       ! Test #1, reserved

       inuse = lu.eq.stdout .or. lu.eq.stdin .or. lu.eq.stderr

       ! Test #2, in-use

       if(.not.inuse) inquire(unit=lu,opened=inuse,iostat=ios)


       if(lu >= MX_LU) ios=-1
    end do

    if(ios.ne.0) lu=-1
    luavail=lu
  end function luavail

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
  !-----------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: luflush - a uniform interface of system flush()
  !
  ! !DESCRIPTION:
  !
  !       Flush() calls available on many systems are often implementation
  !       dependent.  This subroutine provides a uniform interface.  It
  !       also ignores invalid logical unit value.
  !
  ! !INTERFACE:

  subroutine luflush(unit)
    integer,optional,intent(in) :: unit

    ! !REVISION HISTORY:
    !       13Mar98 - Jing Guo <guo@thunder> - initial prototype/prolog/code
    !EOP
    !_______________________________________________________________________
    character(len=*),parameter :: myname_=myname//'::luflush'

    integer :: ier
    integer :: lu

    ! Which logical unit number?

    lu=stdout
    if(present(unit)) lu=unit
    if(lu < 0) return

    ! The following call may be system dependent.

#ifdef sysIRIX64
    call flush(lu,ier)
#else
#if sysAIX 
    call flush_(lu)      ! Function defined in xlf reference document.
#else
    call flush(lu)
#endif
#endif

  end subroutine luflush
  !-----------------------------------------------------------------------
end module m_ioutil
!.

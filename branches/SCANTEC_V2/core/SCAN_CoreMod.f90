!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!
!                  SCAMTeC - GDAD/CPTEC/INPE - 2010                   !
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!
! Copyright 2010 Free Software Foundation, Inc.                       !
!                                                                     !
! This program is free software; you can redistribute it and/or modify!
! it under the terms of the GNU General Public License as published by!
! the Free Software Foundation; either version 2 of the License, or   !
! (at your option) any later version.                                 !
!                                                                     !
! This program is distributed in the hope that it will be useful,     !
! but WITHOUT ANY WARRANTY; without even the implied warranty of      !
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       !
! GNU General Public License for more details.                        !
!                                                                     !
! You should have received a copy of the GNU General Public License   !
! along with GNU Emacs; see the file COPYING.  If not, write to the   !
! Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,    !
! Boston, MA 02110-1301, USA.                                         !
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!


MODULE SCAM_coreMOD
  !BOP
  !
  ! !MODULE: SCAM_coreMod
  ! 
  ! !DESCRIPTION: 
  !  The code in this file contains the basic datastructures and 
  !  control routines for the operation of SCAMTeC
  !
  !  \subsubsection{Overview}
  !
  !
  !  \begin{description}
  !
  !
  !
  ! !REVISION HISTORY: 
  !  30 Sep 2010    Joao Gerd  
  !                 Initial Specification
  ! 
  ! !USES:

  USE SCAN_GlobalType
  USE SCAN_UtilsMod                        ! Utilities for SCAMTeC running
  USE SCAN_DataMod                         ! Grid Data Structure
  USE SCAN_TimeMod, only: jul2cal, cal2jul ! Time operations
  USE SCAN_StringMod                       ! String Manipulation
  USE SCAN_ModelPlugin                     ! A model register 
!  USE SCAM_OutputMOD , only: write_2d      !
  USE SCAN_bstatistic                      !
  USE m_ioutil
  USE m_metri_precip

  IMPLICIT NONE
  PRIVATE

  !---------------------------------------------------------------------
  ! !PUBLIC MEMBER FUNCTIONS:
  !---------------------------------------------------------------------

  public :: SCAN_Config_init
  public :: SCAN_Init
  public :: SCAN_Run
  public :: SCAN_Finalize
  public :: SCAN_EndRun


  !---------------------------------------------------------------------
  !
  !---------------------------------------------------------------------
  character(len=*),parameter :: myname='SCAM_coreMod'

CONTAINS
  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !               INPE/CPTEC Data Assimilation Group                   !
  !---------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: SCAM_Config_init - Configure some apects of SCANTEC
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  SUBROUTINE SCAN_Config_init()

    implicit none

    ! !REVISION HISTORY:
    !       07ct10 - Joao Gerd
    !           Initial prototaype Code
    !EOP

    !_____________________________________________________________________

    character(len=*),parameter :: myname_=myname//'::SCAN_Config_init'

    !
    !  0. Hello
    !

#ifdef DEBUG
    WRITE(6,'(     2A)')'Hello from ', myname_
#endif

    !
    !  1. Read information about statistical analisys
    !

    CALL readcard()

    !
    !  2. Grid Reallocation to 0-360 if necessary
    !

    WHERE(dom(:)%ll_lon.LT.0.)dom(:)%ll_lon=dom(:)%ll_lon+360.
    WHERE(dom(:)%ur_lon.LT.0.)dom(:)%ur_lon=dom(:)%ur_lon+360.    

    !
    !  3. Time configuration
    !

    scamtec%atime          = scamtec%starting_time
    scamtec%ftime          = scamtec%starting_time

    scamtec%time_step      = 1
    scamtec%ftime_idx      = 1
    scamtec%loop_count     = 1
    scamtec%atime_flag     = .true.


    scamtec%hist_incr      = real(scamtec%hist_time/24.0d0)
    scamtec%aincr          = real(scamtec%atime_step/24.0d0)
    scamtec%fincr          = real(scamtec%ftime_step/24.0d0)


    scamtec%ntime_steps    = ( ( cal2jul(scamtec%ending_time) - &
                              cal2jul(scamtec%starting_time) +  &
                              scamtec%aincr ) / scamtec%aincr )

    scamtec%ntime_forecast = ( scamtec%Forecast_time / scamtec%ftime_step ) + 1

    Allocate(scamtec%ftime_count(scamtec%ntime_forecast))
    scamtec%ftime_count    = 0
    scamtec%ftime_count(1) = 1

#ifdef DEBUG    
   write(6,'(A,F9.3)')'history increment    :',scamtec%hist_incr
   write(6,'(A,F9.3)')'Analisys increment   :',scamtec%aincr
   write(6,'(A,F9.3)')'Forecast increment   :',scamtec%aincr
   write(6,'(A,I9.3)')'N time steps         :',scamtec%ntime_steps
   write(6,'(A,I9.3)')'N forecat time steps :',scamtec%ntime_forecast
#endif

  END SUBROUTINE SCAN_Config_init

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !               INPE/CPTEC Data Assimilation Group                   !
  !---------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: SCAM_init - Initialize all global variables of SCANTEC
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  SUBROUTINE SCAN_Init()

    implicit none

    ! !REVISION HISTORY:
    !       07ct10 - Joao Gerd
    !           Initial prototaype Code
    !EOP

    !_____________________________________________________________________

    character(len=*),parameter :: myname_=myname//'::SCAN_Init'
    integer :: i

    !
    !  0. Hello
    !

#ifdef DEBUG
    WRITE(6,'(     2A)')'Hello from ', myname_
#endif

    !
    !  1. Registering models to be used
    !

    call SCAN_ModelPluginRegister( )

    !
    !  2. Registering observations to be used
    !

    call SCAN_ObsPluginRegister( )

    !
    !  3. Registering statistical Methods
    !

    call SCAN_StatPluginRegister( )

    !
    !  4. Configure SCANTEC Grid Matrices
    !

    call SCAN_GridConf( )

    !
    !  5. Allocating memory
    !

    call SCAN_AllocDataMem( )

    !
    ! 6. Data Init
    !

    call SCAN_DataInit( )

    !
    !  7. Models Init
    !

    DO I=1,size(scamtec%Init_ModelID)
       call SCAN_ModelInit(scantec%Init_ModelID(I))
    END DO

  END SUBROUTINE SCAN_Init
  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !               INPE/CPTEC Data Assimilation Group                   !
  !---------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: SCAN_RUN - Run SCANTEC
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  SUBROUTINE SCAN_RUN()

    implicit none

    ! !REVISION HISTORY:
    !       07ct10 - Joao Gerd
    !           Initial prototaype Code
    !EOP
    !------------------------------------------------------------------

    character(len=*),parameter :: myname_=myname//'::SCAN_RUN'
    integer                    :: NExp

    !
    !  0. Hello
    !
    
       WRITE(*,'(a72)')'!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!'
       WRITE(*,'(a72)')'!                          Running SCANTEC                            !'
       WRITE(*,'(a72)')'!      Please wait while the system performing the statistics         !'
       WRITE(*,'(a72)')'!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~!'

#ifdef DEBUG
    WRITE(6,'(     2A)')'Hello from ', myname_
#endif

    !
    !  1. Loop over time and experiments
    !

     DO WHILE (.NOT.is_last_step())
        write(*,'(2(1x,I10.10),1x,I3.2)')scamtec%atime, scamtec%ftime, int(abs(cal2jul(scamtec%atime)-cal2jul(scamtec%ftime))*24)

        DO NExp=1,scantec%nexp

           CALL SCAM_GetModelData ( NExp )  ! Load Files: Analisys, Forecast and Climatology
!           CALL SCAM_GetObsData ( NExp )  ! Load Files: Analisys, Forecast and Climatology
           
           IF(Precipitation_Flag .EQ. 0) CALL SCAM_StatCalc ( )        ! Calculate all Statiscs defined in config file
!           CALL SCAM_WriteStats ( NExp)  ! File Statistical Files
           IF(Precipitation_Flag .EQ. 1)then
              write(*,*)'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
              write(*,*)''
              write(*,*)'ATENCAO!!! Metrica precipitacao Ligada. Então Estatistica Basica Desligada!'
              write(*,*)'' 
              write(*,*)'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
              CALL HistoStat ( NExp )  ! Calculate histogram  (descomentar esse para o teste)
           ENDIF

        ENDDO

        call SCAM_NextStep( )
     ENDDO


  END SUBROUTINE SCAN_RUN


  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !               INPE/CPTEC Data Assimilation Group                   !
  !---------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: SCAM_Finalize - Finalize all processes of SCAMTeC
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  SUBROUTINE SCAM_Finalize

    implicit none

    ! !REVISION HISTORY:
    !       07ct10 - Joao Gerd
    !           Initial prototaype Code
    !EOP

    character(len=*),parameter :: myname_=myname//'::SCAM_Finalize'

    !
    !  0. Hello
    !

#ifdef DEBUG
    WRITE(6,'(     2A)')'Hello from ', myname_
#endif

  END SUBROUTINE SCAM_Finalize
 
  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !               INPE/CPTEC Data Assimilation Group                   !
  !---------------------------------------------------------------------
  !BOP
  !
  ! !IROUTINE: SCAM_Finalize - verify if julian is the last day 
  !                            of run of SCAMTeC analisys
  !
  ! !DESCRIPTION:
  !
  ! !INTERFACE:

  recursive SUBROUTINE SCAM_EndRun( )
!     implicit none
!     integer, intent(in) :: jd
!     integer, intent(in) :: jd_incr
!     integer, intent(in) :: jd_end


    !REVISION HISTORY:
    !  Initial Code :: Joao Gerd - 17Aug2012
    !
    !EOP

!    character(len=*),parameter :: myname_=myname//'::SCAM_EndRun'

    !
    !  0. Hello
    !

!#ifdef DEBUG
!    WRITE(6,'(     2A)')'Hello from ', myname_
!#endif
    
!   scamtec%atime=jul2cal(cal2jul(scamtec%atime)+scamtec%incr)
!   print*,scamtec%atime,scamtec%ending_time
!   if (scamtec%atime.ge.scamtec%ending_time) call exit()

  END SUBROUTINE SCAM_EndRun


  SUBROUTINE SCAM_NextStep()
     implicit none
     REAL(DP) :: aincr
     REAL(DP) :: fincr
     integer :: I, Nx, Ny
     integer :: ii, jj
     INTEGER :: atimebufr

     scamtec%loop_count = scamtec%loop_count + 1

     I  = scamtec%loop_count
     Nx = scamtec%ntime_steps
     Ny = scamtec%ntime_forecast

     ii = ceiling((I)/float(Ny))
     jj = ( I + Ny ) - Ny * ii

     aincr = (ii-1) * scamtec%aincr
     fincr = (jj-1) * scamtec%fincr
     
     atimebufr               = scamtec%atime
     scamtec%atime           = jul2cal(cal2jul(scamtec%starting_time)+aincr)
     scamtec%ftime           = jul2cal(cal2jul(scamtec%atime)+fincr)
     scamtec%ftime_idx       = jj
     scamtec%ftime_count(jj) = scamtec%ftime_count(jj) + 1
     scamtec%atime_flag      = (atimebufr.ne.scamtec%atime)

     if (scamtec%atime_flag)scamtec%time_step = scamtec%time_step + 1


  END SUBROUTINE

!BOP
! !ROUTINE: is_last_step
! \label{is_last_step}
!
! !INTERFACE:
function is_last_step( )
   implicit none
! !ARGUMENTS: 
   logical :: is_last_step
! 
! !DESCRIPTION:
!
! Function returns true on last timestep.
!
!  \begin{description}
!   \item [is\_last\_step]
!     result of the function 
!  \end{description}
!EOP

   is_last_step = .false.
   if(scamtec%atime .gt. scamtec%ending_time) then
      is_last_step = .true.
   endif
   
end function is_last_step
END MODULE SCAM_coreMOD
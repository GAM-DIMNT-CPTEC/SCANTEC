MODULE scantec_module
  use m_constants
  use m_ioutil, only: stdout
  use MathExpress, only: MathOper
  !   use scan_ConvFunc

  implicit none

  !
  ! scantec data type
  !

  type scanType

     !
     ! General Variables
     !

     integer(kind = i4) :: starting_time      ! Initial time
     integer(kind = i4) :: ending_time        ! End time
     integer(kind = i4) :: time_step          ! Atual time step in hours
     integer(kind = i4) :: loop_count         !
     character(len=normalStr) :: tables       ! directory of config tables
     character(len=tinyStr)   :: TimeStepType ! forward or backward
     !
     ! Analisys Variables
     !
     integer(kind = i4) :: atime              ! Analisys time
     integer(kind = i4) :: atime_step         ! Analisys time step
     integer(kind = i4) :: ntime_steps        ! total # of Analisys time step
     real(kind = r8)    :: aincr              ! Analisys time increment
     logical            :: atime_flag         ! is it a new date reference (not forecast)?

     !
     ! Forecast Variables
     !
     integer(kind = i4) :: ftime              ! forecast time
     integer(kind = i4) :: ftime_step         ! Forecast time step 
     integer(kind = i4) :: ntime_forecast     ! total # of forecast time step
     real(kind = r8)    :: fincr              ! Forecast time increment
     integer(kind = i4) :: Forecast_time      ! Forecast total time
     integer(kind = i4) :: ftime_idx          ! forecast time idx count
     integer(kind = i4), Allocatable :: ftime_count(:)  
     CHARACTER(len=LongStr), PUBLIC :: output_dir ! 
     !
     ! History Variables
     !
     integer(kind = i4) :: hist_time
     real(kind = r8)    :: hist_incr          ! history time increment
     !
     ! SCANTEC Grid Info
     !
     real(kind = r4)    :: gridDesc(50)
     real(kind = r4)    :: udef
     integer(kind = i4) :: nxpt
     integer(kind = i4) :: nypt
     integer(kind = i4) :: npts

     !
     !
     !
     integer(kind = i4)                   :: nvar
     character(len=tinyStr), allocatable  :: VarName(:)
     character(len=shortStr), allocatable :: VarDesc(:)
     !
     !    flag to use/no use climatology
     !
     integer(kind = i4) :: cflag
     !
     ! Model info
     !
     integer, pointer         :: nexp => null()
     type(ModelType), pointer :: CurrModel  => null()
     type(ModelType), pointer :: FirstModel => null()

     ! for mathematical evaluation

     class(MathOper), pointer :: MathEval => null()

     !
     ! routines
     !
   contains
     procedure, public :: insertModel => insertModel_
     procedure, public :: getModel => getModel_
     procedure, public :: getField => getField_
     procedure, public :: getBitMap => getBitMap_

  end type scanType

  type(scanType) :: scantec

  type ModelType
     character(len=LongStr) :: Name_
     character(len=LongStr) :: FileName_
     character(len=tinyStr) :: FileType_
     character(len=tinyStr) :: ExpName_
     character(len=tinyStr) :: Type_ ! Reference, Experiment, climatology
     real(kind = r4)        :: undef_

     ! grid info
     real                      :: GDesc(200)
     type(GridDef),    pointer :: gridInfo => null()
     type(GridDef),    pointer :: FirstGridInfo => null()

     !interp info to scantec domain
     integer(kind=i4), allocatable :: n11(:), n12(:), n21(:), n22(:)
     real(kind=r4),    allocatable :: w11(:), w12(:), w21(:), w22(:)

     ! Field
     real(kind=r4), pointer :: Field(:,:) => null()
     logical, pointer       :: bitMap(:,:) => null()

     !Vars to evaluate from model
     type(EvalVar), pointer :: var => null()
     type(EvalVar), pointer :: FirstVar => null()

     type(ModelType),  pointer :: next => null()

   contains
     procedure, public :: getModelVar => getModelVar_
     procedure, public :: getDimInfo => getDimInfo_
     procedure, public :: getDimVec => getDimVec_
     procedure, public :: getMapping => getMapping_
  end type ModelType


  type GridDef
     character(len=ShortStr) :: DName       ! dimension name
     character(len=ShortStr) :: mapping     ! Linear, Levels, gauss
     integer                 :: num         ! number of points
     real                    :: start_coord
     real                    :: incr_coord
     real, pointer           :: coord(:) => null()
     type(GridDef), pointer  :: next => null()
  endtype GridDef

  type EvalVar
     character(len=shortStr) :: Sys_ ! Scantec variable name
     character(len=shortStr) :: mod_ ! Model variable name

     ! Information about variable if it need be 
     ! derivate from others variables
!     logical          :: deriv_ ! .true. need use function to obtain model variavle
!     type(strArray), pointer :: funcArg => null()
!     type(strArray), pointer :: FirstFuncArg => null()

     ! Field info
     real(kind = r4), pointer :: Field(:) => null()
     logical, pointer         :: bitMap(:) => null()

     type(EvalVar), pointer :: next => null()
  end type EvalVar

  type strArray
     character(len=tinyStr)  :: str_
     type(strArray), pointer :: next => null()
  end type strArray


contains

  !------------------------------------------------------------!
  !scanType

  function getFirstModel(self) result(Model)
    class(scanType), intent(in) :: self
    type(ModelType), pointer :: Model

    Model => self%FirstModel
  end function getFirstModel

  subroutine insertModel_(self, ModelType, ModelName, ExpName, FileName)
    class(scanType),  intent(inout) :: self
    character(len=*), intent(in   ) :: ModelName
    character(len=*), intent(in   ) :: ModelType
    character(len=*), intent(in   ) :: ExpName
    character(len=*), intent(in   ) :: FileName

    !verify if is the first model to include
    if(.not.associated(self%FirstModel))then
       allocate(self%nexp); self%nexp = 0
       allocate(self%FirstModel)
       self%currModel => self%FirstModel
    else
       allocate(self%currModel%next)
       self%currModel => self%currModel%next
    endif

    self%currModel%Name_     = trim(ModelName)
    self%currModel%FileName_ = trim(FileName)
    self%currModel%Type_     = trim(ModelType)
    self%currModel%ExpName_  = trim(ExpName)
    if(ModelType .eq. 'Experiment') self%nexp = self%nexp + 1

  end subroutine insertModel_

  function getModel_(self, MType_, MName_) result(Model)
    class(scanType),  intent(inout) :: self
    character(len=*), intent(in   ) :: MType_
    character(len=*), intent(in   ) :: MName_
    type(ModelType), pointer :: Model


    Model => self%FirstModel
    do while(associated(Model))
       if (trim(Model%Name_) .eq. trim(MName_) .and.&
            trim(Model%Type_) .eq. trim(MType_)) return
       Model => Model%next
    enddo

    write(stdout,'(A,3(1x,A))')'Model Name or Model Type not found!',&
         trim(MType_),'->',trim(MName_)
    stop 99024

  end function getModel_

  subroutine getField_(self, ExpName, Field, istat)
    class(scanType), intent(in) :: self
    character(len=*), intent(in) :: ExpName
    real, pointer, intent(out) :: Field(:,:)
    integer, optional, intent(out) :: istat

    type(ModelType), pointer :: Model => null()

    if(present(istat)) istat = 0
    Model => self%FirstModel
    do while(associated(Model))
       if (trim(ExpName) .eq. trim(Model%ExpName_))then
          Field => Model%Field
          return
       endif
       Model => Model%next
    enddo
    if(present(istat)) then
       istat = -1
    else
       write(stdout,'(A,1x,A)') 'unknow Experient Name',trim(ExpName)
       stop 99025
    endif
  end subroutine getField_


  subroutine getBitMap_(self, ExpName, BitMap, istat)
    class(scanType), intent(in) :: self
    character(len=*), intent(in) :: ExpName
    logical, pointer, intent(out) :: BitMap(:,:)
    integer, optional, intent(out) :: istat

    type(ModelType), pointer :: Model => null()


    if(present(istat)) istat = 0
    Model => self%FirstModel
    do while(associated(Model))
       if (trim(ExpName) .eq. trim(Model%ExpName_))then
          BitMap => Model%BitMap
          return
       endif
       Model => Model%next
    enddo
    if(present(istat)) then
       istat = -1
    else
       write(stdout,'(A,1x,A)')'unknow Experiment Name',trim(ExpName)
       stop 99026
    endif
  end subroutine getBitMap_

  !------------------------------------------!
  ! ModelType

  function getModelVar_(self,VarName) result(varInfo)
    class(ModelType),  intent(in) :: self
    character(len=*), intent(in) :: VarName
    type(EvalVar), pointer :: varInfo

    type(EvalVar), pointer :: ModelVar => null()

    VarInfo => self%FirstVar
    do while(associated(VarInfo))
       if(trim(VarName).eq.trim(VarInfo%Sys_)) return
       VarInfo => VarInfo%next
    enddo

    write(stdout,'(A,1x,A)')'unknow variable Name',trim(VarName)

  end function getModelVar_


  function getDimInfo_(self, mdim) result(vdim)
    class(ModelType),  intent(in   ) :: self
    character(len=*), intent(in   ) :: mdim
    integer, pointer :: vdim

    type(gridDef), pointer :: grid => null()

    grid => self%FirstGridInfo
    do while(associated(grid))
       if(trim(mdim) .eq. trim(grid%DName))then
          vdim => grid%num
          return
       endif
       grid => grid%next
    enddo

  end function getDimInfo_


  function getDimVec_(self, mdim) result(vdim)
    class(ModelType),  intent(in   ) :: self
    character(len=*), intent(in   ) :: mdim
    real, pointer :: vdim(:)

    type(gridDef), pointer :: grid => null()
    grid => self%FirstGridInfo
    do while(associated(grid))
       if(trim(mdim) .eq. trim(grid%DName))then
          vdim => grid%coord
          return
       endif
       grid => grid%next
    enddo
    write(stdout,'(A,1x,2A,1x,A)')'Dimension not found in',&
         trim(self%Name_),'.model :',trim(mdim)
    stop 99027

  end function getDimVec_

  function getMapping_(self, mdim) result(vdim)
    class(ModelType),  intent(in   ) :: self
    character(len=*), intent(in   ) :: mdim
    character(len=ShortStr), pointer :: vdim

    type(gridDef), pointer :: grid => null()

    grid => self%FirstGridInfo
    do while(associated(grid))
       if(trim(mdim) .eq. trim(grid%DName))then
          vdim => grid%mapping
          return
       endif
       grid => grid%next
    enddo

  end function getMapping_




END MODULE scantec_module

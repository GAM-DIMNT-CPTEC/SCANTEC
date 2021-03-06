!-----------------------------------------------------------------------------!
!           Group on Data Assimilation Development - GDAD/CPTEC/INPE          !
!-----------------------------------------------------------------------------!
!BOP
!
! !MODULE: scan_MetForm.f90
!
! !DESCRIPTON: Este modulo tem por proposito apresentar rotinas e funcoes para 
!              a conversão de variaveis meteorologicas.
!                 
!\\
!\\
! !INTERFACE:
!

Module scan_MetForm

  IMPLICIT NONE
  PRIVATE

  !
  ! Funções para obter variaveis meteorologicas 
  !

  public :: svap  ! Pressão de Vapor Saturado
  public :: vapp  ! Pressão de Vapor
  public :: hmxr1 ! Razão de Mistura, utiliza umidade especifica: w(q)
  public :: hmxr2 ! Razão de Misture, utiliza pressão de vapor e pressao atm: w(p,e)
  public :: umes1 ! Umidade Específica, utiliza somente razao de mistura: q(w)
  public :: umes2 ! Umidade Específica, utiliza td e pressao atm: q(p,td)
  public :: umes3 ! Umidade Específica, utiliza pressao atm, temperatura do ar e umidade relativa: q(p,t,rh)
  public :: umrl  ! Umidade Relativa
  public :: tpor  ! Temperatura do Ponto de Orvalho
  public :: vtmp1 ! Temperatura Virtual, utiliza temperatura do ar e Umidade Especifica: tv(t,q)
  public :: vtmp2 ! Temperatura Virtual, utiliza temperatura do ar, umidade relativa e pressao atm: tv(t,rh,p)

  interface umes
     module procedure umes1,& ! utiliza somente razao de mistura: q(w)
                      umes2,& ! utiliza td e pressao atm: q(p,td)
                      umes3   ! utiliza pressao atm, temperatura do ar e umidade relativa: q(p,t,rh)
  end interface umes

  interface hmxr
     module procedure hmxr1,& ! utiliza umidade especifica: w(q)
                      hmxr2   ! utiliza pressão de vapor e pressao atm: w(p,e)
  end interface hmxr

  interface vtmp
     module procedure vtmp1,& ! utiliza temperatura do ar e Umidade Especifica: tv(t,q)
                      vtmp2   ! utiliza temperatura do ar, umidade relativa e pressao atm: tv(t,rh,p)
  end interface vtmp


  !
  ! !PARAMETERS:
  !

  real, parameter  :: p0 = 1000.00 ! pressão de referencia [hPa]
  real, parameter  :: Rd =  287.04 ! Constante dos Gases para o ar seco [ Joutes/K/kg]
  real, parameter  :: Rv =  461.50 ! Constante dos Gases para o Vapor d'água [ Joutes/K/kg]
  real, parameter  :: cp = 1003.50 ! Calor especifico para o ar seco [Joules/K/kg]
  real, parameter  :: L  = 2257e03 ! Calor latente de vaporização [Joules/kg]

  character(len=1024),parameter :: myname='scan_MetForm'


  !
  ! !REVISION HISTORY:
  !  19 FebT 2013 - J. G. de Mattos - Initial Version
  !
  ! !SEE ALSO:
  !   
  ! !BUGS:
  !
  !  Nenhum conhecido
  !
  !EOP
  !-----------------------------------------------------------------------------!

Contains
  !
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  svap
  !
  ! !DESCRIPTION: Esta funcao calcula a pressão de vapor de saturacao [Pa]
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function svap(temp) result(es)
    implicit none
    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: temp ! Temperatura do ar [Graus Celsius]

    !
    ! !OUTPUT PARAMETERS:
    !

    real :: es ! pressão de vapor saturado [Pa]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Bolton, D., The computation of equivalent potential temperature, 
    !                  Monthly Weather Review, 108, 1046-1053, 1980.. 
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    character(len=1024),parameter :: myname_=trim(myname)//'::svap'

    es = 611.2*exp((17.67 * temp)/(temp+243.5))

    end function svap
  !EOC
  !
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  vapp
  !
  ! !DESCRIPTION: Esta função calcula a pressão de vapor [Pa]
  !
  !\\
  !\\
  ! !INTERFACE:
  pure function vapp (es, rh)result(ee)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: es ! Pressão de vapor saturado [Pa]
    real, intent(in) :: rh ! Umidade relativa [%]

    !
    ! !OUTPUT PARAMETERS:
    !

    real              :: ee ! pressao de vapor [Pa]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Huschke, Glossary of Meteorology, 1959, p. 477
    !      
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !
    character(len=1024),parameter :: myname_=trim(myname)//'::vapp'

    ee = ( rh / 100.0 ) * es

  end function vapp
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  hmxr2
  !
  ! !DESCRIPTION: Esta funcao calcula a razao de mistura [-]
  !               
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function hmxr2 (pres, ee)result(w)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: pres  ! pressão atmosferica [Pa]
    real, intent(in) :: ee    ! pressao de vapor [Pa]

    !
    ! !OUTPUT PARAMETERS:
    !

    real :: w  ! razão de mistura [-]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Wallace & Hobbs, Atmospheric Science, 1977, Academic Press 
    !
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    real :: eps

    character(len=1024),parameter :: myname_=trim(myname)//'::hmxr2'

    eps = Rd / Rv

    w  = eps * ( ee / (pres - ee) ) 

    end function hmxr2
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  hmxr1
  !
  ! !DESCRIPTION: Esta rotina calcula a razao de mistura [-] a partir da umidade
  !               especifica [kg/kg].
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function hmxr1(q) result(w)

    Implicit None
    !
    ! !INPUT PARAMETERS:
    !
    real, intent(in) :: q ! Umidade especifica [kg/kg]
    !
    ! !OUTPUT PARAMETERS:
    !

    real :: w  ! Razão de Mistura [-]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    character(len=1024),parameter :: myname_=trim(myname)//'::hmxr1'

    w  = (q / ( 1 - q ) )

  end function hmxr1
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  umes1
  !
  ! !DESCRIPTION: Esta funcao calcula a umidade especifica [kg/kg]
  !               
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function umes1(w) result(q)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: w ! razao de mistura [kg/kg]

    !
    ! !OUTPUT PARAMETERS:
    ! 

    real :: q  ! Umidade especifica [kg/kg]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Huschke, Glossary of Meteorology, 1959, p. 530
    !      
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !
    character(len=1024),parameter :: myname_=trim(myname)//'::umes1'

    q  = w / (1.0 + w)
    !     q1 = q1 * 1000.0

  end function umes1
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  umes2
  !
  ! !DESCRIPTION: Esta funcao calcula a umidade especifica [kg/kg]
  !               
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function umes2(pres,td) result(q)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: pres ! Pressao Atmosférica [Pa]
    real, intent(in) :: td   ! Tempeatura do Ponto de Orvalho [C]

    !
    ! !OUTPUT PARAMETERS:
    ! 

    real :: q  ! Umidade especifica [kg/kg]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Bolton, D., The computation of equivalent potential temperature, 
    !                  Monthly Weather Review, 108, 1046-1053, 1980. 
    !      
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    real :: e

    character(len=1024),parameter :: myname_=trim(myname)//'::umes2'

    e  = 611.20*exp((17.67*Td)/(Td + 243.5)); 
    q  = (0.622 * e)/(pres - (0.378 * e)); 
    !     q2 = q2 * 1000.0

  end function umes2
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  umes3
  !
  ! !DESCRIPTION: Esta funcao calcula a umidade especifica [kg/kg]
  !               
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function umes3(pres,t,rh) result(q)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: pres ! Pressao Atmosférica [Pa]
    real, intent(in) :: t    ! Tempeatura do Ar [C]
    real, intent(in) :: rh   ! Umidade Relativa [%]


    !
    ! !OUTPUT PARAMETERS:
    ! 

    real :: q  ! Umidade especifica [kg/kg]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Bolton, D., The computation of equivalent potential temperature, 
    !                  Monthly Weather Review, 108, 1046-1053, 1980. 
    !      
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    real :: eps
    real :: es
    real :: ee
    real :: w

    character(len=1024),parameter :: myname_=trim(myname)//'::umes3'

    eps = Rd / Rv
    es  = 611.20 * exp((17.67 * t)/(t + 243.5));
    ee  = es * ( rh / 100.0 );
    eps = Rd / Rv
    w   = eps * ( ee / (pres - ee) ) 
    q  = w / (1.0 + w)

  end function umes3
  !EOC

  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  tpor
  !
  ! !DESCRIPTION: Esta funcao calcula a Temperatura do Ponto de Orvalho [C] 
  !               
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function tpor(t,rh) result(td)
    implicit none

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: rh ! Umidade Relativa [%]
    real, intent(in) :: t  ! Tempeatura do Ar [C]

    !
    ! !OUTPUT PARAMETERS:
    ! 

    real :: td ! Temperatura do Ponto de Orvalho [C]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    ! !SEE ALSO: 
    !     Bolton, D., The computation of equivalent potential temperature, 
    !                  Monthly Weather Review, 108, 1046-1053, 1980. 
    !      
    !     
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    real :: e, es

    character(len=1024),parameter :: myname_=trim(myname)//'::dptp'

    es = 6.112 * exp((17.67 * t)/(t + 243.5)); 
    e = es * ( rh / 100.0 ); 
    Td = log(e/6.112)*243.5/(17.67-log(e/6.112)); 

  end function tpor
  !EOC
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  umrl
  !
  ! !DESCRIPTION: Esta função calcula a umidade relativa [%] a partir da
  !               razão de mistura [-], da pressao de vapor de saturacao [hPa] e
  !               da pressão atmosferica [hPa].
  !\\
  !\\
  ! !INTERFACE:


  pure function umrl(pres,w,es) result(rh)
    Implicit None

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: pres ! Presão Atmosférica [Pa]
    real, intent(in) :: w    ! Razão de Mistura [-]
    real, intent(in) :: es   ! Presão de Vapor Saturada [Pa]

    !
    ! !OUTPUT PARAMETERS:
    !

    real :: rh  ! Umidade Relativa [%]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    REAL :: ws, eps

    character(len=1024),parameter :: myname_=trim(myname)//'::umrl'

    eps = Rd / Rv
    ws  = (eps*es) / (pres - es);
    rh  = (w/ws) * 100.0

    !  mask to rh > 100 %
    IF(rh .GT. 100.0) rh = 100.0

  end function umrl
  !EOC
  !
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  vtmp2
  !
  ! !DESCRIPTION: Esta função calcula a temperatura virtual [C ou K] a partir da
  !               temperatura do ar [C ou K] e da Umidade especícia [Kg/Kg]
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function vtmp2(t,q) result(tv)

    Implicit None

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: t ! temperatura do ar [C ou K]
    real, intent(in) :: q ! Umidade Específica [kg/Kg]

    !
    ! !OUTPUT PARAMETERS:
    !

    real :: tv  ! temperatura virtural [C ou K]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    character(len=1024),parameter :: myname_=trim(myname)//'::vtmp2'

    tv  = t * ( 1 + 0.61 * ( q / ( 1 - q ) ) ) 

  end function vtmp2
  !EOC
  !
  !-----------------------------------------------------------------------------!
  !BOP
  !
  ! !IROUTINE:  vtmp1
  !
  ! !DESCRIPTION: Esta função calcula a temperatura virtual [C] a partir da
  !               temperatura do ar [C] e da Umidade Relativa [%] e da Pressao
  !               atmosferica [Pa]
  !
  !\\
  !\\
  ! !INTERFACE:

  pure function vtmp1(pres,t,rh) result(tv)

    Implicit None

    !
    ! !INPUT PARAMETERS:
    !

    real, intent(in) :: pres ! Pressão Atmosferica [Pa]
    real, intent(in) :: t    ! temperatura do ar [C]
    real, intent(in) :: rh   ! Umidade Relativa [%]

    !
    ! !OUTPUT PARAMETERS:
    !

    real :: tv  ! temperatura virtural [C]

    !
    !
    ! !REVISION HISTORY: 
    !  19 Feb 2013 - J. G. de Mattos - Initial Version
    !
    !
    !EOP
    !-----------------------------------------------------------------------------!
    !BOC
    !

    real :: eps
    real :: es, ee
    real :: w

    character(len=1024),parameter :: myname_=trim(myname)//'::vtmp1'

    eps = Rd / Rv
    es  = 611.2*exp((17.67 * t)/(t+243.5))
    ee  = ( rh / 100.0 ) * es
    w   = eps * ( ee / (pres - ee) )

    Tv  = t * (1 + w / eps) / (1 + w)


  end function vtmp1
  !EOC
  !
  !-----------------------------------------------------------------------------!

End Module scan_MetForm

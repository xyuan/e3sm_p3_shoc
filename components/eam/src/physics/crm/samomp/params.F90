module params

  use shr_const_mod, only: shr_const_rdair, shr_const_cpdair, shr_const_latvap, &
  shr_const_latice, shr_const_latsub, shr_const_rgas, &
  shr_const_mwwv, shr_const_stebol, shr_const_tkfrz, &
  shr_const_mwdair, shr_const_g, shr_const_karman, &
  shr_const_rhofw
  use params_kind

  implicit none

  !----------------------------------------------
  ! Constants
  !----------------------------------------------

  real(crm_rknd), parameter :: cp    = real( shr_const_cpdair ,crm_rknd)
  real(crm_rknd), parameter :: ggr   = real( shr_const_g      ,crm_rknd)
  real(crm_rknd), parameter :: lcond = real( shr_const_latvap ,crm_rknd)
  real(crm_rknd), parameter :: lfus  = real( shr_const_latice ,crm_rknd)
  real(crm_rknd), parameter :: lsub  = real( lcond + lfus     ,crm_rknd)
  real(crm_rknd), parameter :: rgas  = real( shr_const_rdair  ,crm_rknd)
  real(crm_rknd), parameter :: rv    = real( shr_const_rgas/shr_const_mwwv ,crm_rknd)

  real(crm_rknd), parameter :: diffelq = 2.21D-05     ! Diffusivity of water vapor, m2/s
  real(crm_rknd), parameter :: therco  = 2.40D-02     ! Thermal conductivity of air, J/m/s/K
  real(crm_rknd), parameter :: muelq   = 1.717D-05    ! Dynamic viscosity of air

  real(crm_rknd), parameter :: fac_cond = lcond/cp
  real(crm_rknd), parameter :: fac_fus  = lfus/cp
  real(crm_rknd), parameter :: fac_sub  = lsub/cp

  real(crm_rknd), parameter :: epsv = 0.61D0     ! = (1-eps)/eps, where eps= Rv/Ra

  real(crm_rknd), parameter ::  pi = 3.141592653589793D0

  !----------------------------------------------
  ! Internally set parameters
  !----------------------------------------------

  real(crm_rknd):: ug = 0.        ! Velocity of the Domain's drift in x direction
  real(crm_rknd):: vg = 0.        ! Velocity of the Domain's drift in y direction

  real(crm_rknd), allocatable :: fcor(:)          ! Coriolis parameter
  real(crm_rknd), allocatable :: fcorz(:)         ! Vertical Coriolis parameter
  real(crm_rknd), allocatable :: z0(:)            ! roughness length

  logical, allocatable :: ocean(:)           ! flag indicating that surface is water
  logical, allocatable :: land(:)            ! flag indicating that surface is land

  logical:: docloud       = .true.    ! allow cloud formation
  logical:: doprecip      = .true.    ! allow precipitation
  logical:: dodamping     = .true.    ! Newtonian damping for upper levels
  logical:: dosgs         = .true.    ! sub-grid turbulence scheme
#ifdef MMF_MOMENTUM_FEEDBACK
  logical:: dosurface     = .false.    ! surface scheme to calculate friction within CRM
#else
  logical:: dosurface     = .true.    ! surface scheme to calculate friction within CRM
#endif

  logical:: docoriolis    = .false.   ! not normally used for MMF
  logical:: dowallx       = .false.   ! not normally used for MMF
  logical:: dowally       = .false.   ! not normally used for MMF
  logical:: dotracers     = .false.   ! not normally used for MMF

  integer, parameter :: asyncid = 1

  real(crm_rknd), allocatable :: uhl(:)      ! current large-scale velocity in x near sfc
  real(crm_rknd), allocatable :: vhl(:)      ! current large-scale velocity in y near sfc
contains
  subroutine allocate_params(ncrms)
    implicit none
    integer, intent(in) :: ncrms
    allocate(fcor (ncrms))
    allocate(fcorz(ncrms))
    allocate(z0        (ncrms))
    allocate(ocean     (ncrms))
    allocate(land      (ncrms))
    allocate(uhl       (ncrms))
    allocate(vhl       (ncrms))

    !$omp target enter data map(alloc: fcor )
    !$omp target enter data map(alloc: fcorz)
    !$omp target enter data map(alloc: z0)
    !$omp target enter data map(alloc: ocean)
    !$omp target enter data map(alloc: land)
    !$omp target enter data map(alloc: uhl)
    !$omp target enter data map(alloc: vhl)

    fcor  = 0
    fcorz = 0
    z0 = 0.035D0
    ocean = .false.
    land = .false.
    uhl = 0
    vhl = 0
  end subroutine allocate_params

  subroutine deallocate_params()
    implicit none

    !$omp target exit data map(delete: fcor )
    !$omp target exit data map(delete: fcorz)
    !$omp target exit data map(delete: z0)
    !$omp target exit data map(delete: ocean)
    !$omp target exit data map(delete: land)
    !$omp target exit data map(delete: uhl)
    !$omp target exit data map(delete: vhl)

    deallocate(fcor )
    deallocate(fcorz)
    deallocate(z0)
    deallocate(ocean)
    deallocate(land)
    deallocate(uhl)
    deallocate(vhl)
  end subroutine deallocate_params

  subroutine update_device_params()
    !$omp target update to( fcor )
    !$omp target update to( fcorz)
    !$omp target update to( z0)
    !$omp target update to( ocean)
    !$omp target update to( land)
    !$omp target update to( uhl)
    !$omp target update to( vhl)
  end subroutine update_device_params

  subroutine update_host_params()
    !$omp target update from( fcor )
    !$omp target update from( fcorz)
    !$omp target update from( z0)
    !$omp target update from( ocean)
    !$omp target update from( land)
    !$omp target update from( uhl)
    !$omp target update from( vhl)
  end subroutine update_host_params
end module params

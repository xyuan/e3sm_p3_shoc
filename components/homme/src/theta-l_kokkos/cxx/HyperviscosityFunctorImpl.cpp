/********************************************************************************
 * HOMMEXX 1.0: Copyright of Sandia Corporation
 * This software is released under the BSD license
 * See the file 'COPYRIGHT' in the HOMMEXX/src/share/cxx directory
 *******************************************************************************/

#include "HyperviscosityFunctorImpl.hpp"

#include "Context.hpp"
#include "FunctorsBuffersManager.hpp"
#include "profiling.hpp"

#include "mpi/BoundaryExchange.hpp"
#include "mpi/MpiBuffersManager.hpp"
#include "mpi/Connectivity.hpp"

namespace Homme
{

HyperviscosityFunctorImpl::
HyperviscosityFunctorImpl (const SimulationParams&       params,
                           const Elements&               elements)
 : m_data (params.hypervis_subcycle,params.nu_ratio1,params.nu_ratio2,params.nu_top,params.nu,params.nu_p,params.nu_s,params.hypervis_scaling)
 , m_state   (elements.m_state)
 , m_geometry (elements.m_geometry)
 , m_sphere_ops (Context::singleton().get<SphereOperators>())
 , m_policy_update_states (0, elements.num_elems()*NP*NP*NUM_LEV)
 , m_policy_first_laplace (Homme::get_default_team_policy<ExecSpace,TagFirstLaplaceHV>(elements.num_elems()))
 , m_policy_pre_exchange (Homme::get_default_team_policy<ExecSpace, TagHyperPreExchange>(elements.num_elems()))
{
  // Sanity check
  assert(params.params_set);

  if (m_data.nu_top>0) {

    m_nu_scale_top = ExecViewManaged<Scalar[NUM_LEV]>("nu_scale_top");
    ExecViewManaged<Scalar[NUM_LEV]>::HostMirror h_nu_scale_top;
    h_nu_scale_top = Kokkos::create_mirror_view(m_nu_scale_top);

    constexpr int NUM_BIHARMONIC_PHYSICAL_LEVELS = 3;
    Kokkos::Array<Real,NUM_BIHARMONIC_PHYSICAL_LEVELS> lev_nu_scale_top = { 4.0, 2.0, 1.0 };
    for (int phys_lev=0; phys_lev<NUM_BIHARMONIC_PHYSICAL_LEVELS; ++phys_lev) {
      const int ilev = phys_lev / VECTOR_SIZE;
      const int ivec = phys_lev % VECTOR_SIZE;
      h_nu_scale_top(ilev)[ivec] = lev_nu_scale_top[phys_lev]*m_data.nu_top;
    }
    Kokkos::deep_copy(m_nu_scale_top, h_nu_scale_top);
  }

  // Make sure the sphere operators have buffers large enough to accommodate this functor's needs
  m_sphere_ops.allocate_buffers(Homme::get_default_team_policy<ExecSpace>(m_state.num_elems()));
}

void HyperviscosityFunctorImpl::request_buffers (FunctorsBuffersManager& fbm) const {
  fbm.request_concurrency(m_state.num_elems());
  fbm.request_3d_midpoint_buffers(Buffers::num_3d_scalar_mid_buf, Buffers::num_3d_vector_mid_buf);
}

void HyperviscosityFunctorImpl::init_buffers (const FunctorsBuffersManager& fbm) {
  // TODO
  assert(false);
}

void HyperviscosityFunctorImpl::init_boundary_exchanges () {
  m_be = std::make_shared<BoundaryExchange>();
  auto& be = *m_be;
  auto bm_exchange = Context::singleton().get<MpiBuffersManagerMap>()[MPI_EXCHANGE];
  if (bm_exchange->is_connectivity_set()) {
    bm_exchange->set_connectivity(Context::singleton().get_ptr<Connectivity>());
  }
  be.set_buffers_manager(bm_exchange);
  // be.set_num_fields(0, 0, 4);
  // be.register_field(m_elements.m_buffers.vtens, 2, 0);
  // be.register_field(m_elements.m_buffers.ttens);
  // be.register_field(m_elements.m_buffers.dptens);
  be.registration_completed();
}

void HyperviscosityFunctorImpl::run (const int np1, const Real dt, const Real eta_ave_w)
{
  m_data.np1 = np1;
  m_data.dt = dt/m_data.hypervis_subcycle;
  m_data.eta_ave_w = eta_ave_w;

  // Kokkos::RangePolicy<ExecSpace,TagUpdateStates> policy_update_states(0, m_elements.num_elems()*NP*NP*NUM_LEV);
  // const auto policy_pre_exchange =
  //     Homme::get_default_team_policy<ExecSpace, TagHyperPreExchange>(
  //         m_elements.num_elems());
  // for (int icycle = 0; icycle < m_data.hypervis_subcycle; ++icycle) {
  //   GPTLstart("hvf-bhwk");
  //   biharmonic_wk_dp3d ();
  //   GPTLstop("hvf-bhwk");
  //   // dispatch parallel_for for first kernel
  //   Kokkos::parallel_for(policy_pre_exchange, *this);
  //   Kokkos::fence();

  //   // Exchange
  //   assert (m_be->is_registration_completed());
  //   GPTLstart("hvf-bexch");
  //   m_be->exchange();
  //   GPTLstop("hvf-bexch");

  //   // Update states
  //   Kokkos::parallel_for(policy_update_states, *this);
  //   Kokkos::fence();
  // }
}

void HyperviscosityFunctorImpl::biharmonic_wk_dp3d() const
{
  // For the first laplacian we use a differnt kernel, which uses directly the states
  // at timelevel np1 as inputs. This way we avoid copying the states to *tens buffers.
  
  // auto policy_first_laplace = Homme::get_default_team_policy<ExecSpace,TagFirstLaplaceHV>(m_elements.num_elems());
  // Kokkos::parallel_for(policy_first_laplace, *this);
  // Kokkos::fence();

  // // Exchange
  // assert (m_be->is_registration_completed());
  // GPTLstart("hvf-bexch");
  // m_be->exchange(m_elements.m_geometry.m_rspheremp);
  // GPTLstop("hvf-bexch");

  // // TODO: update m_data.nu_ratio if nu_div!=nu
  // // Compute second laplacian, tensor or const hv
  // if ( m_data.consthv ) {
  //   auto policy_second_laplace = Homme::get_default_team_policy<ExecSpace,TagSecondLaplaceConstHV>(m_elements.num_elems());
  //   Kokkos::parallel_for(policy_second_laplace, *this);
  // }else{
  //   auto policy_second_laplace = Homme::get_default_team_policy<ExecSpace,TagSecondLaplaceTensorHV>(m_elements.num_elems());
  //   Kokkos::parallel_for(policy_second_laplace, *this);
  // }
  // Kokkos::fence();
}

} // namespace Homme

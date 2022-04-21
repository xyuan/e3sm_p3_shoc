#ifndef EKAT_ARCH_HPP
#define EKAT_ARCH_HPP

#include <string>
#include <Kokkos_Core.hpp>

/*
 * Architecture-related calls
 */

namespace ekat {

std::string active_avx_string();

std::string ekat_config_string();

template <typename ExeSpace>
struct OnGpu { enum : bool { value = false }; };
#if defined(KOKKOS_ENABLE_CUDA)
template <> struct OnGpu<Kokkos::Cuda> { enum : bool { value = true }; };
#elif defined(KOKKOS_ENABLE_SYCL)
template <> struct OnGpu<Kokkos::Experimental::SYCL> { enum : bool { value = true }; };
#endif

} // namespace ekat

#endif // EKAT_ARCH_HPP

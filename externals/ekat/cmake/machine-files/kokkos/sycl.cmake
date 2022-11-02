# Settings used when SYCL is the Kokkos backend
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS " -O2 -Wno-deprecated-declarations -fsycl-max-parallel-link-jobs=16 -fsycl-device-code-split=per_source -DSYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING_") 
set(CMAKE_CXX_EXTENSIONS FALSE CACHE BOOL "OFF")
set(CMAKE_VERBOSE_MAKEFILE TRUE CACHE BOOL "ON")
set(DBUILD_SHARED_LIBS TRUE CACHE BOOL "ON")
set(Kokkos_ARCH_INTEL_XEHP TRUE CACHE BOOL "ON") # for ATS and AoT compilation (**)
set(Kokkos_ARCH_INTEL_PVC  FALSE CACHE BOOL "OFF") # for PVC and AoT compilation
set(Kokkos_ENABLE_SERIAL TRUE CACHE BOOL "ON")
set(Kokkos_ENABLE_OPENMP FALSE CACHE BOOL "OFF")
set(Kokkos_ENABLE_SYCL TRUE CACHE BOOL "ON")
set(Kokkos_ENABLE_DEPRECATED_CODE_3 FALSE CACHE BOOL "OFF") # (if not building Kokkos Kernels, this can be OFF)


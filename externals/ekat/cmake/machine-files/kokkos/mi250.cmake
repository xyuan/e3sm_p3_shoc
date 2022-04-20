include (${CMAKE_CURRENT_LIST_DIR}/generic.cmake)

# Enable MI250 arch in kokkos
option(Kokkos_ARCH_VEGA90A "" ON)
set(Kokkos_ENABLE_VEGA90A TRUE CACHE BOOL "")

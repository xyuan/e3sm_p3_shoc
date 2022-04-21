#!/bin/bash
cmake \
  -C ../cmake/machine-files/jlse_gpu.cmake          \
  -D CMAKE_CXX_STANDARD=17                          \
  -D CMAKE_BUILD_TYPE:STRING=DEBUG                  \
  -D CMAKE_CXX_COMPILER:STRING=mpicxx               \
  -D CMAKE_Fortran_COMPILER:STRING=mpifort          \
  -D CMAKE_INSTALL_PREFIX:PATH=${INSTALL_DIR}       \
  -D EKAT_DISABLE_TPL_WARNINGS:BOOL=ON              \
  -D EKAT_ENABLE_TESTS:BOOL=ON                      \
  -D EKAT_TEST_DOUBLE_PRECISION:BOOL=ON             \
  -D EKAT_TEST_SINGLE_PRECISION:BOOL=OFF            \
  -D EKAT_TEST_MAX_THREADS:STRING=8                 \
  -D Kokkos_ENABLE_SYCL=ON                          \
  -D CMAKE_CXX_FLAGS="-DKOKKOS_ENABLE_SYCL"         \
  ../

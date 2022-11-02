#!/bin/bash
cmake \
  -C ../cmake/machine-files/jlse.cmake              \
  -D CMAKE_CXX_STANDARD=17                          \
  -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON                 \
  -D CMAKE_BUILD_TYPE:STRING=Debug                  \
  -D EKAT_DISABLE_TPL_WARNINGS:BOOL=ON              \
  -D EKAT_ENABLE_TESTS:BOOL=ON                      \
  -D EKAT_TEST_DOUBLE_PRECISION:BOOL=ON             \
  -D EKAT_TEST_SINGLE_PRECISION:BOOL=OFF            \
  -D EKAT_TEST_MAX_THREADS:STRING=1                 \
  -D Kokkos_ENABLE_SYCL=ON                          \
  -D CMAKE_CXX_FLAGS="-DKOKKOS_ENABLE_SYCL -fsycl -fsycl-targets=spir64_gen -Xsycl-target-backend \"-device 12.50.4\""   \
  ../

make -j16

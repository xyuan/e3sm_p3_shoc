#!/bin/bash
cmake \
  -C ../cmake/machine-files/crusher.cmake           \
  -D CMAKE_BUILD_TYPE:STRING=DEBUG                  \
  -D CMAKE_CXX_COMPILER:STRING=hipcc                \
  -D CMAKE_Fortran_COMPILER:STRING=ftn              \
  -D CMAKE_VERBOSE_MAKEFILE:BOOL=ON                 \
  -D EKAT_DISABLE_TPL_WARNINGS:BOOL=ON              \
  -D EKAT_ENABLE_TESTS:BOOL=ON                      \
  -D EKAT_TEST_DOUBLE_PRECISION:BOOL=ON             \
  ../

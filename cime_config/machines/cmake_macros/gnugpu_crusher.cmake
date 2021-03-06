enable_language(HIP)
string(APPEND FFLAGS " -Wno-implicit-interface -fallow-argument-mismatch")
if (NOT DEBUG)
  string(APPEND CFLAGS " -O2 -I$ENV{MPICH_DIR}/include -I$ENV{ROCM_PATH}/include")
  string(APPEND CXXFLAGS " -O2 -I$ENV{MPICH_DIR}/include -I$ENV{ROCM_PATH}/include")
  string(APPEND FFLAGS " -O2 -I$ENV{MPICH_DIR}/include -I$ENV{ROCM_PATH}/include")
  string(APPEND HIP_FLAGS " -O3 -D__HIP_ROCclr__ -D__HIP_ARCH_GFX90A__=1 --rocm-path=$ENV{ROCM_PATH} --offload-arch=gfx90a -x hip")
endif()
if (DEBUG)
  string(APPEND HIP_FLAGS " -O0 -g -D__HIP_ROCclr__ -D__HIP_ARCH_GFX90A__=1 --rocm-path=$ENV{ROCM_PATH} --offload-arch=gfx90a -x hip")
endif()
if (COMP_NAME STREQUAL gptl)
  string(APPEND CPPDEFS " -DHAVE_SLASHPROC")
endif()
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-rpath,${GCC_X86_64}/lib64")
string(APPEND CPPDEFS " -DCPRGNU")
string(APPEND SLIBS " -L$ENV{PNETCDF_PATH}/lib -lpnetcdf -L$ENV{HDF5_PATH}/lib -lhdf5_hl -lhdf5 -L$ENV{NETCDF_C_PATH}/lib -lnetcdf -L$ENV{NETCDF_FORTRAN_PATH}/lib -lnetcdff")
string(APPEND CXX_LIBS " -lstdc++")
set(CXX_LINKER "FORTRAN")
set(MPICC "hipcc")
set(MPICXX "hipcc")
set(MPIFC "ftn")
set(SCC "cc")
set(SCXX "CC")
set(SFC "ftn")
set(NETCDF_PATH "$ENV{NETCDF_DIR}")
set(PNETCDF_PATH "$ENV{PNETCDF_DIR}")
set(USE_HIP "TRUE")
set(PIO_FILESYSTEM_HINTS "gpfs")

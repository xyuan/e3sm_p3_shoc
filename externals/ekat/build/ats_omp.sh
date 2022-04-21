#!/bin/bash
module use /soft/restricted/CNDA/modulefiles
module purge
module load oneapi
###module load oneapi/2021.08.15.005
###module load oneapi/2021.04.30.004
####module load mpi/aurora_mpich/gnu-sockets/39.1
####module load mpi/intel_mpi
###module load mpi/aurora_mpich/icc-sockets-debug/43.2
module load cmake
module load python
module load iprof
module load gdb
module swap -f intel_compute_runtime/release/agama-prerelease-272
##module swap -f mpi mpi/intel_mpi

unset ARCH
unset NCRMS
unset LIBOMPTARGET_DEBUG
unset LIBOMPTARGET_PLUGIN

export EnableCrossDeviceAccess=1
export LIBOMPTARGET_PLUGIN=LEVEL0 
export LIBOMPTARGET_DEBUG=4
export LIBOMPTARGET_ONEAPI_SHOW_BUILD_LOG=1
export NCHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NFHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NCRMS=48
# for intel mpi
#export CC=mpiicx
#export CXX=mpiicpx
#export FC=mpiifx
# for mpich
export CC="mpicxx -cxx=icx"
export CXX="mpicxx -cxx=icpx "
export FC="mpif90 -fc=ifx "
export YAKL_ARCH_OPENMP45="TRUE"
export FFLAGS="-O3 -g -fiopenmp -fopenmp-targets=spir64='-mllvm -vpo-paropt-enable-64bit-opencl-atomics=true' "
export CXXFLAGS="-O3 -g -fiopenmp -fopenmp-targets=spir64='-mllvm -vpo-paropt-enable-64bit-opencl-atomics=true' "
export CFLAGS="-O3 -g -fiopenmp -fopenmp-targets=spir64='-mllvm -vpo-paropt-enable-64bit-opencl-atomics=true' "
##export FFLAGS=""
##export CXXFLAGS=""
##export CFLAGS=""
export ARCH="OPENMP45"
export YAKL_ARCH="OPENMP45"
##export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"
##export YAKL_CUB_HOME="`pwd`/../../../../../../../../externals/cub"
export YAKL_HOME="/home/xyuan/yakl/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wuda/soft/hdf5/1.8.16-parallel/intel18/lib:/home/wuda/soft/szip/2.1.1/intel18/lib:/soft/restricted/CNDA/mpich/drop41.1/mpich-ofi-sockets-icc-default-ats-drop41/lib

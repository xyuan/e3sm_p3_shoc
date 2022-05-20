#!/bin/bash

##export MODULEPATH=/soft/restricted/CNDA/modulefiles
module use /soft/restricted/CNDA/modulefiles
module purge
##module load oneapi
module load oneapi/eng-compiler/2022.01.30.007
###module load oneapi/2021.08.15.005
###module load oneapi/2021.04.30.004
####module load mpi/aurora_mpich/gnu-sockets/39.1
####module load mpi/intel_mpi
###module load mpi/aurora_mpich/icc-sockets-debug/43.2
module load cmake/3.22.1
module load gdb
module load iprof
#module switch -f intel_compute_runtime/release/agama-prerelease-303 
#module switch -f intel_compute_runtime/release/agama-prerelease-272
#module switch -f intel_compute_runtime/release/agama-prerelease-260
#module switch -f intel_compute_runtime/release/agama-prerelease-246
#module switch -f intel_compute_runtime/release/agama-prerelease-402

unset ARCH
unset NCRMS
unset LIBOMPTARGET_DEBUG
unset LIBOMPTARGET_PLUGIN
unset EnableWalkerPartition
unset SYCL_DEVICE_FILTER
unset CC
unset FC
unset CXX

export EnableCrossDeviceAccess=1
export LIBOMPTARGET_PLUGIN=LEVEL0
export LIBOMPTARGET_DEBUG=0
export ZE_AFFINTY_MASK=0.0   # 0 for 1 tile
##export SYCL_DEVICE_FILTER=opencl:cpu #for cpu run
export SYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING=1


export NCHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NFHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NCRMS=1
#Intel compiler
#export CC="mpiicx "
#export CXX="mpiicpx "
#export FC="mpiifx "
#Mpich
export CC="mpicc -cc=icx "
export CXX="mpicxx -cxx=dpcpp "
export FC="mpif90 -fc=ifx"
export YAKL_ARCH_SYCL="TRUE"
export FFLAGS="-O3 "
export CXXFLAGS="-O3 "
export ARCH="SYCL"
export MACH="jlse"
export YAKL_SYCL_FLAGS="-fsycl '-Wno-deprecated-declarations' "
#export YAKL_HOME="/gpfs/jlse-fs0/projects/climate/xyuan/yakl"
export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"
#export YAKL_CUB_HOME="`pwd`/../../../../../../../../externals/cub"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wuda/soft/hdf5/1.8.16-parallel/intel18/lib:/home/wuda/soft/szip/2.1.1/intel18/lib:/soft/restricted/CNDA/mpich/drop41.1/mpich-ofi-sockets-icc-default-ats-drop41/lib

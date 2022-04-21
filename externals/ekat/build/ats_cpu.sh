#!/bin/bash

##export MODULEPATH=/soft/restricted/CNDA/modulefiles
module use /soft/restricted/CNDA/modulefiles
module purge
module load oneapi
###module load oneapi/2021.08.15.005
###module load oneapi/2021.04.30.004
####module load mpi/aurora_mpich/gnu-sockets/39.1
####module load mpi/intel_mpi
###module load mpi/aurora_mpich/icc-sockets-debug/43.2
module load cmake
###module load python
module load iprof

unset ARCH
unset NCRMS
unset LIBOMPTARGET_DEBUG
unset LIBOMPTARGET_PLUGIN

export LIBOMPTARGET_PLUGIN=LEVEL0 
###export LIBOMPTARGET_DEBUG=4
export NCHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NFHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NCRMS=768
###export CC=mpiicc
###export CXX=mpiicpc
###export FC=mpiifx
export CC="mpicxx -cxx=icx"
export CXX="mpicxx -cxx=icpx "
export FC="mpif90 -fc=ifx "
###export YAKL_ARCH_OPENMP45="TRUE"
export FFLAGS=" -O3 -g "
export CXXFLAGS=" -O3 -g "
##export ARCH="OPENMP45"
export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"
export YAKL_CUB_HOME="`pwd`/../../../../../../../../externals/cub"
##export YAKL_HOME="/home/xyuan/yakl/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wuda/soft/hdf5/1.8.16-parallel/intel18/lib:/home/wuda/soft/szip/2.1.1/intel18/lib:/soft/restricted/CNDA/mpich/drop41.1/mpich-ofi-sockets-icc-default-ats-drop41/lib

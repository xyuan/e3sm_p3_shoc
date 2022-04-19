#!/bin/bash

source $MODULESHOME/init/bash
module load  PrgEnv-gnu/8.1.0  craype-accel-amd-gfx908
module load craype-network-ofi cray-mpich/8.1.7
module load cray-hdf5 cray-netcdf

unset ARCH
unset NCRMS
unset MACH
unset YAKL_DEBUG
unset FFLAGS
unset CXXFLAGS

export MPICH_SMP_SINGLE_COPY_MODE=CMA
export MPICH_GPU_SUPPORT_ENABLED=0

export YAKL_DEBUG=true
export MACH="spock"
export NCHOME=${PE_NETCDF_DIR}/gnu/9.1
export NFHOME=${PE_NETCDF_DIR}/gnu/9.1
export MPIHOME=${CRAY_MPICH_DIR}
export NCRMS=112

export CC=mpicc
export CXX=mpic++
export FC=mpif90
export FFLAGS=" -g -O3 -ffree-line-length-none "
export CXXFLAGS=" -g -O3 "
export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"
export YAKL_CUB_HOME="`pwd`/../../../../../../../../externals/cub"



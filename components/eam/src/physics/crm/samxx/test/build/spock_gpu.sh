#!/bin/bash

source $MODULESHOME/init/bash
module load PrgEnv-cray craype-accel-amd-gfx908 rocm 
module load craype-network-ofi cray-mpich/8.1.7
module load cray-hdf5 cray-netcdf

unset ARCH
unset NCRMS
unset MACH
unset YAKL_DEBUG

export MPIR_CVAR_GPU_EAGER_DEVICE_MEM=0
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_SMP_SINGLE_COPY_MODE=CMA

export YAKL_DEBUG=true
export MACH="spock"
export NCHOME=${NETCDF_DIR}
export NFHOME=${NETCDF_DIR}
export MPIHOME=${CRAY_MPICH_DIR}
export NCRMS=128
export CC=hipcc
export CXX=hipcc
export FC=ftn
export FFLAGS=" -g -O3 -h noomp -h noacc -I${ROCM_PATH}/include "
export CXXFLAGS=" -g  -O3 -I${ROCM_PATH}/include "
export YAKL_ARCH="HIP"
export YAKL_HIP_FLAGS="-O3 -g -D__HIP_ROCclr__ -D__HIP_ARCH_GFX908__=1 --rocm-path=${ROCM_PATH} --offload-arch=gfx908 -x hip" 
export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"



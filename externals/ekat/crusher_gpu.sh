#!/bin/bash

source $MODULESHOME/init/bash
module purge
module load PrgEnv-cray/8.3.3 craype-accel-amd-gfx90a rocm/4.5.0
module load craype-network-ofi  cray-mpich/8.1.14
module load cray-hdf5 cray-netcdf cmake

unset ARCH
unset YAKL_ARCH
unset NCRMS
unset MACH
unset CC
unset CXX
unset FC
unset CXXFLAGS
unset FFLAGS

export MPIR_CVAR_GPU_EAGER_DEVICE_MEM=0
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_SMP_SINGLE_COPY_MODE=CMA

export YAKL_DEBUG=true
export MACH="crusher"
export NCHOME=${NETCDF_DIR}
export NFHOME=${NETCDF_DIR}
export MPIHOME=${CRAY_MPICH_DIR}
export NCRMS=168
export CC=hipcc
export CXX=hipcc
export FC=ftn
export FFLAGS=" -O3 -h noomp -h noacc -eZ -I${ROCM_PATH}/include -I${MPICH_DIR}/include "
export CXXFLAGS="  -O3 -I${ROCM_PATH}/include -I${MPICH_DIR}/include "
export ARCH="HIP"
export YAKL_ARCH="HIP"
export YAKL_HIP_FLAGS="-O3 -D__HIP_ROCclr__ -D__HIP_ARCH_GFX90A__=1 --rocm-path=${ROCM_PATH} --offload-arch=gfx90a -x hip " 
export YAKL_HOME="`pwd`/../../../../../../../../externals/YAKL"

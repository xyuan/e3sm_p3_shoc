#!/bin/bash
module use /soft/restricted/CNDA/modulefiles
module purge

#module load spack/linux-opensuse_leap15-x86_64
#module load libnl/3.3.0-gcc-10.2.0-h7m7thf
#module load rdma-core/36.3-gcc-10.2.0-l2rnrjy
#module load libfabric/1.14.0-gcc-10.2.0-hp2bsva
#module load libpciaccess/0.16-gcc-10.2.0-kluhisj
#module load hwloc/master-gcc-10.2.0-fbu4tbk
#module load mpi/aurora_mpich/icc-sockets/47.2  #(aurora_mpich:default)
#module load gcc/10.2.0-gcc-10.2.0-yudlyez
#module load .igc/release/20220614.1  #(.igc)
#module load intel_gpu_env/multi_gpu
#module load intel_gpu_env/platform_default
#module load intel_compute_runtime/release/agama-prerelease-475 #(match-dgpu-kmd:sdk-default)
module load oneapi

#module load oneapi/eng-compiler/2022.01.30.003
#module load oneapi/release/2022.01.30.004
#module load oneapi/eng-compiler/2022.01.30.007
#module load oneapi/eng-compiler/2022.06.30.002

module load cmake/3.22.1
module load gdb
module load iprof
#module switch -f intel_compute_runtime/release/agama-prerelease-303 
#module switch -f intel_compute_runtime/release/agama-prerelease-272
#module switch -f intel_compute_runtime/release/agama-prerelease-260
#module switch -f intel_compute_runtime/release/agama-prerelease-246
#module switch -f intel_compute_runtime/release/agama-devel-425
#module switch -f intel_compute_runtime/release/agama-devel-449

unset ARCH
unset NCRMS
unset LIBOMPTARGET_DEBUG
unset LIBOMPTARGET_PLUGIN
unset EnableWalkerPartition
unset SYCL_DEVICE_FILTER
unset EnableImplicitScaling

#export EnableCrossDeviceAccess=1
#export LIBOMPTARGET_PLUGIN=LEVEL0
#export LIBOMPTARGET_DEBUG=4
#export ZE_AFFINTY_MASK=0.0   # 0 for 1 tile
export EnableImplicitScaling=0 # for PVC node
##export SYCL_DEVICE_FILTER=opencl:cpu #for cpu run
export SYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING=1
export SYCL_DEVICE_FILTER=level_zero
export IGC_DisableAddingAlwaysAttribute=1

export NCHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NFHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NCRMS=1
#Intel compiler
export CC="mpiicx "
export CXX="mpiicpx "
export FC="mpiifx "
#Mpich
#export CC="mpicc -cc=icx "
#export CXX="mpicxx -cxx=dpcpp "
#export FC="mpifort -fc=ifx "
export YAKL_ARCH_SYCL="TRUE"
export FFLAGS=" -O2 -g "
export CXXFLAGS=" -O2 -g -fsycl '-Wno-deprecated-declarations' "
export ARCH="SYCL"
export MACH="jlse_gpu"
export YAKL_HOME="/gpfs/jlse-fs0/projects/climate/xyuan/yakl/"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wuda/soft/hdf5/1.8.16-parallel/intel18/lib:/home/wuda/soft/szip/2.1.1/intel18/lib:/soft/restricted/CNDA/mpich/drop41.1/mpich-ofi-sockets-icc-default-ats-drop41/lib

#!/bin/bash
module use /soft/restricted/CNDA/modulefiles
module purge

#ONEAPI_MPICH_GPU=NO_GPU module load oneapi/release/2022.01.30.004 
#Using nogpu mpich
#module load oneapi/eng-compiler/2022.01.30.008
module load oneapi/eng-compiler/2022.06.30.002
#module load oneapi
module load cmake/3.20.3
module load gdb
module load iprof
#module switch -f intel_compute_runtime/release/agama-prerelease-303 
#module switch -f intel_compute_runtime/release/agama-prerelease-272
#module switch -f intel_compute_runtime/release/agama-prerelease-260
#module switch -f intel_compute_runtime/release/agama-prerelease-246
module switch -f intel_compute_runtime/release/agama-prerelease-402
#module switch -f intel_compute_runtime/release/agama-prerelease-438
#module switch -f intel_compute_runtime/release/agama-prerelease-475
#module switch -f intel_compute_runtime/release/agama-prerelease-519
#module switch -f  intel_compute_runtime/release/agama-devel-425 
#module switch -f intel_compute_runtime/release/agama-devel-449

unset ARCH
unset NCRMS
unset LIBOMPTARGET_DEBUG
unset LIBOMPTARGET_PLUGIN
unset EnableWalkerPartition
unset SYCL_DEVICE_FILTER
unset CC
unset FC
unset CXX
unset ZE_AFFINTY_MASK
unset YAKL_HOME
unset YAKL_SYCL_FLAGS
unset SYCL_DEVICE_FILTER
unset EnableCrossDeviceAccess
unset EnableImplicitScaling
unset IGC_DumpToCurrentDir
unset IGC_ShaderDumpEnable
unset IGC_DisableAddingAlwaysAttribute

#export EnableCrossDeviceAccess=1
#export LIBOMPTARGET_PLUGIN=LEVEL0
#export LIBOMPTARGET_DEBUG=0
export EnableImplicitScaling=0 # for PVC node
#export SYCL_DEVICE_FILTER=opencl
export SYCL_DEVICE_FILTER=level_zero 
#export SYCL_DEVICE_FILTER=opencl:cpu
export SYCL_CACHE_PERSISTENT=0
export ONEAPI_MPICH_GPU=NO_GPU
export ZE_AFFINTY_MASK=0.0   # 0 for 1 tile
#export SYCL_DEVICE_FILTER=opencl:cpu #for cpu run
#export SYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING=1
export GATOR_INITIAL_MB=4000mb
export GATOR_DISABLE=0
export IGC_DumpToCurrentDir=1
#export IGC_ShaderDumpEnable=1
#export IGC_PrintErrorsAndWarningsIfAny=1
#export DisableAddingAlwaysAttribute=1
#export IGC_DisableAddingAlwaysAttribute=1

export LD_LIBRARY_PATH=/home/xyuan/.lib:${LD_LIBRARY_PATH}
export NCHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NFHOME="/home/wuda/soft/netcdf/4.4.1c-4.2cxx-4.4.4f-parallel/intel18"
export NCRMS=16
#Intel compiler
#export CC="mpiicx"
#export CXX="mpiicpx"
#export FC="mpiifx"
#Mpich
export CC="mpicc -cc=icx "
export CXX="mpicxx -cxx=icpx "
export FC="mpifort -fc=ifx "
#non mpi build
#export CC="icx"
#export CXX="icpx"
#export FC="ifx"
export YAKL_ARCH_SYCL="TRUE"
export FFLAGS=" -O2 "
export CXXFLAGS=" -O2 "
export ARCH="SYCL"
export MACH="jlse"
#export YAKL_SYCL_FLAGS="-fsycl -v -fsycl-max-parallel-link-jobs=16 -fsycl-device-code-split=per_source -DSYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING_" # for AoT
#export YAKL_SYCL_FLAGS="-fsycl -fsycl-max-parallel-link-jobs=16 -fsycl-device-code-split=per_source -DSYCL_DISABLE_PARALLEL_FOR_RANGE_ROUNDING_ -fsycl-targets=spir64_gen -Xsycl-target-backend \"-device 12.60.3\" '-Wno-deprecated-declarations' " # for AoT PVC build
export YAKL_SYCL_FLAGS="-fsycl -fsycl-targets=spir64_gen -Xsycl-target-backend \"-device xehp\" '-Wno-deprecated-declarations' " # for AoT ATS build
#export YAKL_SYCL_FLAGS="-fsycl -fsycl-targets=spir64_gen -Xsycl-target-backend \"-device 12.50.4\" '-Wno-deprecated-declarations' "
export YAKL_HOME="/gpfs/jlse-fs0/projects/climate/xyuan/e3sm_p3_shoc.github/externals/YAKL"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/wuda/soft/hdf5/1.8.16-parallel/intel18/lib:/home/wuda/soft/szip/2.1.1/intel18/lib:/soft/restricted/CNDA/mpich/drop41.1/mpich-ofi-sockets-icc-default-ats-drop41/lib

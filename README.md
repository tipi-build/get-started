# Build with CMake RE
👉🏻 [Follow the get-started tutorial](https://tipi.build/documentation/0000-getting-started-cmake)

## TL;DR;
1. First authenticate with `tipi connect`
2. Pick one of the following build execution contexts :

### Local Containerized and Hermetic
```sh
# configure
cmake-re -S . -B ./build-hermetic -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
# build
cmake-re --build ./build-hermetic
```

### Remotely on L1 Digital Twin
```sh
# configure
cmake-re --remote -S . -B ./build-remote -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
# build
cmake-re --build ./build-remote -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
```

### Distributed on L2 on an EngFlow RBE (Remote Build Execution Cluster)
```sh
# Setup RBE Cluster
export RBE_service=<cluster-address:port>
export RBE_tls_client_auth_key=/path/to/engflow.key
export RBE_tls_client_auth_cert=/path/to/engflow.crt
# configure
cmake-re --distributed -S . -B ./build-distributed   -GNinja -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
# build
cmake-re --build ./build-distributed -j500
```

➡️ **Combine L1 + L2 for the best experience** with `--remote --distributed`.

## Non-containerized, non-hermetic on your local host
```
cmake-re --host -S . -B ./build-host -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re --build ./build-host
```


### L2 Remote Caching with Compiler Launcher + enhanced Ccache

📘 [See Documentation + Rationale](https://tipi.build/documentation/0359-ccache-storage-service)


```bash
# Setup RBE Cluster
export RBE_service=<cluster-address:port>
export RBE_tls_client_auth_key=/path/to/engflow.key
export RBE_tls_client_auth_cert=/path/to/engflow.crt
#export RBE_instance=cmake

# Remote caching only not remote execution
export RBE_exec_strategy=local

# Configure scandeps cache
mkdir -p $PWD/.scandeps_cache
export RBE_cache_dir=$PWD/.scandeps_cache
export RBE_deps_cache_max_mb=512
export RBE_enable_deps_cache="true"

export RBE_exec_root=$PWD
export RBE_platform="InputRootAbsolutePath=$PWD"
export RBE_server_address=unix://$PWD/unix-sock-reproxy
export RBE_canonicalize_working_dir="False"
export RBE_reproxy_wait_seconds=5
export RBE_service_no_auth="true"
export RBE_use_application_default_credentials="true"

# Generate a new UUID for the session
export RBE_invocation_id=$(uuidgen)


bootstrap -server_address $RBE_server_address -shutdown
bootstrap -server_address $RBE_server_address -logtostderr -v 3

# Configure + Build remote ccache'd
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache
cmake -S . -B ./build-cached -G Ninja

# Enable caching post configure (configure checks are randomly stored, do generally not benefit from caching)
export TIPI_INTERCALATED_COMPILER_LAUNCHER=rewrapper
export CCACHE_PREFIX=tipi-compiler-driver
cmake --build ./build-cached -j12

echo "EngFlow Build Profile: https://engflow-cache-rbe-gcp-staging.sc-corp.net/api/profiling/v1/instances/${RBE_instance:-default}/invocations/${RBE_invocation_id}"
```
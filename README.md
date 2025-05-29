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

# Build with tipi

## Build and run all tests
```
tipi build . -t linux --test all
```

## Synchronizes build back : 
```
tipi build . -t linux --test all --sync-build
```

# Build with CMake

```
cmake -S . -B cmake-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake --build cmake-build
```

# Build with CMake RE

## Locally
```
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build
```

## Remotely
```
export TIPI_LOCAL_CONTAINER_RUNNER=ON
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build --remote
```

### Run test  
```
export TIPI_LOCAL_CONTAINER_RUNNER=ON
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build --run-test main --remote
```
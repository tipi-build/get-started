# Build with tipi

## Build and run all tests
```
tipi build . -t linux --test all
tipi-v56 build . -t linux-wine-msvc -j128
tipi-v56 build . -t linux --test all
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

## Non-containerized, non-hermetic on your local host
```
cmake-re --host -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re --host -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build
```

### Containerized
```
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build --run-test main --remote --monitor
```

### Remotely
```
cmake-re --remote -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build 
```


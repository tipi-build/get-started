# Build with CMake RE

👉🏻 [Follow the get-started tutorial](https://tipi.build/documentation/0000-getting-started-cmake)

## TL;DR; 
### Containerized and Hermetic
```
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build --run-test main --monitor
```

### Remotely
```
tipi connect
cmake-re --remote -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build 
```

## Non-containerized, non-hermetic on your local host
```
cmake-re --host -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake
cmake-re --host -S . -B cmake-re-build -DCMAKE_TOOLCHAIN_FILE=environments/linux.cmake --build cmake-re-build
```


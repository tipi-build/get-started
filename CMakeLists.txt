cmake_minimum_required(VERSION 3.27.6)

project(get-started)
enable_testing()

# Install fmt
Include(FetchContent)
set(FMT_TEST OFF CACHE BOOL "" FORCE)
FetchContent_Declare(fmt
  GIT_REPOSITORY https://github.com/fmtlib/fmt.git
  GIT_TAG        9.0.0
  OVERRIDE_FIND_PACKAGE
)
FetchContent_MakeAvailable(fmt)
find_package(fmt REQUIRED)

# Add a test executable
add_executable(main test/main.cpp)
target_link_libraries(main PRIVATE fmt::fmt)

add_test(NAME main COMMAND ${CMAKE_CROSSCOMPILING_EMULATOR} $<TARGET_FILE:main> )
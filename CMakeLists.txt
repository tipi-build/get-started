set(FETCHCONTENT_QUIET OFF CACHE BOOL "" FORCE)
cmake_minimum_required(VERSION 3.15)

project(hello-world)
enable_testing()

Include(FetchContent)
set(FMT_TEST OFF CACHE BOOL \"\" FORCE)
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG        9.0.0
    OVERRIDE_FIND_PACKAGE
    )
FetchContent_MakeAvailable(fmt)

add_executable(main test/main.cpp)
add_test(NAME main COMMAND  $<TARGET_FILE:main> )

find_package(fmt REQUIRED)
target_link_libraries(main PRIVATE fmt::fmt)
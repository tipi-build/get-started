cmake_minimum_required(VERSION 3.15)

project(hello-world)
enable_testing()

add_executable(main test/main.cpp)
add_test(NAME main COMMAND  $<TARGET_FILE:main> )

find_package(fmt REQUIRED)
target_link_libraries(main PRIVATE fmt::fmt)

# Copyright (c) 2013, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_CLANG_CMAKE)
  return()
else()
  set(POLLY_COMPILER_CLANG_CMAKE 1)
endif()


find_program(CMAKE_C_COMPILER clang)
find_program(CMAKE_CXX_COMPILER clang++)


set(
    CMAKE_C_COMPILER
    "${CMAKE_C_COMPILER}"
    CACHE
    STRING
    "C compiler"
    FORCE
)

set(
    CMAKE_CXX_COMPILER
    "${CMAKE_CXX_COMPILER}"
    CACHE
    STRING
    "C++ compiler"
    FORCE
)

set( CMAKE_CXX_FLAGS_INIT "-fuse-ld=lld" CACHE STRING "g++ flags overriden to use lld" FORCE)
set( CMAKE_C_FLAGS_INIT "-fuse-ld=lld" CACHE STRING "gcc flags overriden to use lld" FORCE)
set( CMAKE_EXE_LINKER_FLAGS_INIT "-fuse-ld=lld" CACHE STRING "ld flags overriden to use lld" FORCE)
add_link_options("LINKER:-z,notext")
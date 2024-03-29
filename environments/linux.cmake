
if(DEFINED POLLY_LINUX_CMAKE_)
  return()
else()
  set(POLLY_LINUX_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")

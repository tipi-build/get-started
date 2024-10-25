
if(DEFINED POLLY_LINUX_CMAKE_)
  return()
else()
  set(POLLY_LINUX_CMAKE_ 1)
endif()

if (NOT CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux") 
  message(FATAL_ERROR "Incompatible System Toolchain, you are running the build on '${CMAKE_HOST_SYSTEM_NAME}' and this toolchain is made for 'Linux'.")
endif()

include("${CMAKE_CURRENT_LIST_DIR}/compiler/clang.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake")

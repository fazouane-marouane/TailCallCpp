cmake_minimum_required(VERSION 2.8)
include(CheckCXXCompilerFlag)
project(TailCallCpp CXX)

# Special output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(CHECK_CXX_COMPILER_USED1)

elseif("${CMAKE_CXX_COMPILER_ID}x" STREQUAL "MSVCx")
  # using Visual Studio C++
elseif("${CMAKE_CXX_COMPILER_ID}x" STREQUAL "Intelx")
  # using Intel C++
else()
  # GCC or Clang
  # C++11
  CHECK_CXX_COMPILER_FLAG("-std=c++17" COMPILER_SUPPORTS_CXX17)
  CHECK_CXX_COMPILER_FLAG("-std=c++1z" COMPILER_SUPPORTS_CXX1Z)
  CHECK_CXX_COMPILER_FLAG("-std=c++14" COMPILER_SUPPORTS_CXX14)
  CHECK_CXX_COMPILER_FLAG("-std=c++1y" COMPILER_SUPPORTS_CXX1Y)
  CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
  CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
  if(COMPILER_SUPPORTS_CXX17)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17")
  elseif(COMPILER_SUPPORTS_CXX1Z)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1z")
  elseif(COMPILER_SUPPORTS_CXX14)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
  elseif(COMPILER_SUPPORTS_CXX1Y)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
  elseif(COMPILER_SUPPORTS_CXX11)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
  elseif(COMPILER_SUPPORTS_CXX0X)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  else()
      message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
  endif(COMPILER_SUPPORTS_CXX17)

  if(CHECK_CXX_COMPILER_USED2)
  elseif("${CMAKE_CXX_COMPILER_ID}x" MATCHES "Clangx")
    # using Clang
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Weverything -Wno-c++98-compat -Wno-c++98-compat-pedantic -Wno-global-constructors")
    #set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++")
  elseif("${CMAKE_CXX_COMPILER_ID}x" STREQUAL "GNUx")
    # using GCC
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic")
  endif(CHECK_CXX_COMPILER_USED2)
endif(CHECK_CXX_COMPILER_USED1)

find_package (Boost REQUIRED)

include_directories (${Boost_INCLUDE_DIRS})
file(GLOB_RECURSE TailCallCpp_Files
    "${TailCallCpp_SOURCE_DIR}/src/*.h"
    "${TailCallCpp_SOURCE_DIR}/src/*.cpp"
)

add_executable (tailCall ${TailCallCpp_Files} main.cpp)

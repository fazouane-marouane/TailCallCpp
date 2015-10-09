#!/bin/bash
set -ev
echo Before install on linux.
if [ "$CXX" == "g++" ]; then
  MY_CXX_Compiler=g++-${MY_GCC_VERSION};
fi
if [ "$CXX" == "clang++" ]; then
  MY_CXX_Compiler=clang++-${MY_CLANG_VERSION};
fi
if [ "$CC" == "gcc" ]; then
  MY_CC_Compiler=gcc-${MY_GCC_VERSION};
fi
if [ "$CC" == "clang" ]; then
  MY_CC_Compiler=clang-${MY_CLANG_VERSION};
fi
echo ${TRAVIS_OS_NAME}
echo ${CXX}
echo ${CC}
echo ${MY_GCC_VERSION}
echo ${MY_CLANG_VERSION}
echo ${MY_CXX_Compiler}
echo ${MY_CC_Compiler}

#!/bin/bash
set -ev
if [ "$CXX" == "g++" ]; then
  export MY_CXX_Compiler=$(which g++-${MY_GCC_VERSION});
fi
if [ "$CXX" == "clang++" ]; then
  export MY_CXX_Compiler=$(which clang++-${MY_CLANG_VERSION});
fi
if [ "$CC" == "gcc" ]; then
  export MY_CC_Compiler=$(which gcc-${MY_GCC_VERSION});
fi
if [ "$CC" == "clang" ]; then
  export MY_CC_Compiler=$(which clang-${MY_CLANG_VERSION});
fi
echo ${TRAVIS_OS_NAME}
echo ${CXX}
echo ${CC}
echo ${MY_GCC_VERSION}
echo ${MY_CLANG_VERSION}
mkdir build
cd build
${MY_CXX_Compiler} --version
${MY_CC_Compiler} --version
cmake --version
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DCMAKE_CXX_COMPILER=${MY_CXX_Compiler} -DCMAKE_C_COMPILER=${MY_CC_Compiler} ..
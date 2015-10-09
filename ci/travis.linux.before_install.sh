#!/bin/bash
set -ev
if [ "$CXX_Cmp" == "g++" ]; then
  export MY_CXX_Compiler=$(which g++-${GCC_Cmp});
fi
if [ "$CXX_Cmp" == "clang++" ]; then
  export MY_CXX_Compiler=$(which clang++-${CLANG_Cmp});
fi
if [ "$CC_Cmp" == "gcc" ]; then
  export MY_CC_Compiler=$(which gcc-${GCC_Cmp});
fi
if [ "$CC_Cmp" == "clang" ]; then
  export MY_CC_Compiler=$(which clang-${CLANG_Cmp});
fi
echo ${TRAVIS_OS_NAME}
echo ${CXX_Cmp}
echo ${CC_Cmp}
echo ${GCC_Cmp}
echo ${CLANG_Cmp}
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
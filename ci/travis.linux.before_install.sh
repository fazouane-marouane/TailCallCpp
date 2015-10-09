#!/bin/bash
set -ev
if [ "${CXX}" == "g++" ]; then
  export MY_CXX_Compiler=$(which g++-${MY_GCC_VERSION});
fi
if [ "${CXX}" == "clang++" ]; then
  export MY_CXX_Compiler=$(which clang++-${MY_CLANG_VERSION});
fi
if [ "${CC}" == "gcc" ]; then
  export MY_CC_Compiler=$(which gcc-${MY_GCC_VERSION});
fi
if [ "${CC}" == "clang" ]; then
  export MY_CC_Compiler=$(which clang-${MY_CLANG_VERSION});
fi
#!/bin/bash
set -ev
if [ "$CXX" == "g++" ]; then
  export MY_CXX_Compiler=$(which g++-${MY_GCC_VERSION});
fi
if [ "$CXX" == "g++" ]; then
  export MY_CC_Compiler=$(which gcc-${MY_GCC_VERSION});
fi
if [ "$CXX" != "g++" ]; then
  export MY_CXX_Compiler=$(which clang++-${MY_CLANG_VERSION});
fi
if [ "$CXX" != "g++" ]; then
  export MY_CC_Compiler=$(which clang-${MY_CLANG_VERSION});
fi
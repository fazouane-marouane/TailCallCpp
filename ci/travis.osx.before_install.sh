#!/bin/bash
set -ev
echo Before install on OSX.
brew update
brew upgrade clang
brew upgrade gcc
export MY_CC_Compiler=${CXX_Cmp}
export MY_CC_Compiler=${CC_Cmp}
mkdir build
cd build
${MY_CXX_Compiler} --version
${MY_CC_Compiler} --version
cmake --version
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DCMAKE_CXX_COMPILER=${MY_CXX_Compiler} -DCMAKE_C_COMPILER=${MY_CC_Compiler} ..
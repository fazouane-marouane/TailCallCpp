#!/bin/bash
mkdir build
cd build
${MY_CXX_Compiler} --version
${MY_CC_Compiler} --version
cmake --version
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DCMAKE_CXX_COMPILER=${MY_CXX_Compiler} -DCMAKE_C_COMPILER=${MY_CC_Compiler} ..
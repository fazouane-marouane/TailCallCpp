#!/bin/bash
set -ev
brew update
brew update clang
export MY_CC_Compiler=${CXX}
export MY_CC_Compiler=${CC}
#!/bin/bash
set -ev
brew update
brew upgrade clang
brew upgrade gcc
export MY_CC_Compiler=${CXX}
export MY_CC_Compiler=${CC}
./ci/travis.install.sh
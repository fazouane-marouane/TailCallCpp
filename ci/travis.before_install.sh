#!/bin/bash
echo ${TRAVIS_OS_NAME}
if [ -z "${TRAVIS_OS_NAME}" ] || [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  echo Before install on linux.
  chmod a+x ./ci/travis.linux.before_install.sh;
  ./ci/travis.linux.before_install.sh;
fi
if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
  echo Before install on OSX.
  chmod a+x ./ci/travis.osx.before_install.sh;
  ./ci/travis.osx.before_install.sh;
fi
mkdir build
cd build
${MY_CXX_Compiler} --version
${MY_CC_Compiler} --version
cmake --version
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DCMAKE_CXX_COMPILER=${MY_CXX_Compiler} -DCMAKE_C_COMPILER=${MY_CC_Compiler} ..
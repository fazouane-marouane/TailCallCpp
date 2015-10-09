#!/bin/bash
if [ -z "${TRAVIS_OS_NAME}" ] || [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  echo Before install on linux.
  ./ci/travis.linux.before_install.sh;
fi
if [ "${TRAVIS_OS_NAME}" = "osx" ]; then
  echo Before install on OSX.
  ./ci/travis.osx.before_install.sh;
fi
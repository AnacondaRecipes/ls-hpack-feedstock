#!/bin/bash
set -ex

# CMakeLists.txt declares CMAKE_MINIMUM_REQUIRED(VERSION 2.8); CMake 4.x refuses
# to configure a project with a minimum below 3.5, so opt in explicitly.
cmake -B _build -G Ninja \
  ${CMAKE_ARGS} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DSHARED=1 \
  -DLSHPACK_XXH=1 \
  .

cmake --build _build

install -d "${PREFIX}/lib" "${PREFIX}/include"
install -m 644 "_build/libls-hpack${SHLIB_EXT}" "${PREFIX}/lib/"
install -m 644 lshpack.h "${PREFIX}/include/"
install -m 644 lsxpack_header.h "${PREFIX}/include/"

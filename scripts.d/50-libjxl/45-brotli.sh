#!/bin/bash

SCRIPT_REPO="https://github.com/google/brotli.git"
SCRIPT_COMMIT="350100a5bb9d9671aca85213b2ec7a70a361b0cd"

ffbuild_enabled() {
    return -1 # unused
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DBUILD_SHARED_LIBS=OFF ..
    ninja -j$(nproc)
    ninja install
}

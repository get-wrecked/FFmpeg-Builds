#!/bin/bash

SCRIPT_REPO="https://github.com/breakfastquay/rubberband.git"
SCRIPT_COMMIT="832f577acbcdfa8c48d19a8381e73428297bec4e"

ffbuild_enabled() {
    [[ $VARIANT == lgpl* ]] && return -1
    return -1 # unused by Medal
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    local myconf=(
        --prefix="$FFBUILD_PREFIX"
        -Ddefault_library=static
        -Dfft=fftw
        -Dresampler=libsamplerate
    )

    if [[ $TARGET == win* || $TARGET == linux* ]]; then
        myconf+=(
            --cross-file=/cross.meson
        )
    else
        echo "Unknown target"
        return -1
    fi

    meson "${myconf[@]}" ..
    ninja -j$(nproc)
    ninja install
}

ffbuild_configure() {
    echo --enable-librubberband
}

ffbuild_unconfigure() {
    echo --disable-librubberband
}

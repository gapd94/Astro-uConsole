#!/usr/bin/env bash
set -euo pipefail

SRC_BASE="/opt/astro-src/indi-3rdparty"
INSTALL_PREFIX="/usr"

echo "[INDI-3RDPARTY] Source build starting"

apt install -y \
    git cmake build-essential \
    libcfitsio-dev \
    libnova-dev \
    libusb-1.0-0-dev \
    libjpeg-dev \
    libcurl4-gnutls-dev \
    libgphoto2-dev \
    libfftw3-dev

mkdir -p "$SRC_BASE"
cd "$SRC_BASE"

if [[ ! -d .git ]]; then
    git clone https://github.com/indilib/indi-3rdparty.git .
else
    git fetch
fi

if [[ -n "${INDI_3RDPARTY_TAG:-}" ]]; then
    git checkout "$INDI_3RDPARTY_TAG"
else
    git pull
fi

mkdir -p build
cd build

cmake .. \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
    -DCMAKE_BUILD_TYPE=Release

make -j$(nproc)
make install
ldconfig

echo "[INDI-3RDPARTY] Installation complete"

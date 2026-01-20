#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-apt}"
SRC_BASE="/opt/astro-src/indi-core"
INSTALL_PREFIX="/usr"

echo "[INDI-CORE] Mode: $MODE"

if [[ "$MODE" == "apt" ]]; then
    if command -v indiserver >/dev/null 2>&1; then
        echo "[INDI-CORE] Already installed (APT)"
        exit 0
    fi

    apt update
    apt install -y \
        indi-bin \
        libindi-dev \
        indi-gpsd \
        indi-weather

    exit 0
fi

# ---- Source build path ----

apt install -y \
    git cmake build-essential \
    libcfitsio-dev \
    libnova-dev \
    libusb-1.0-0-dev \
    libjpeg-dev \
    libcurl4-gnutls-dev \
    libgsl-dev \
    zlib1g-dev

mkdir -p "$SRC_BASE"
cd "$SRC_BASE"

if [[ ! -d .git ]]; then
    git clone https://github.com/indilib/indi.git .
else
    git fetch
fi

if [[ -n "${INDI_CORE_TAG:-}" ]]; then
    git checkout "$INDI_CORE_TAG"
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

echo "[INDI-CORE] Source build complete"

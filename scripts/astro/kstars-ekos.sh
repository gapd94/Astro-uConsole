#!/usr/bin/env bash
set -euo pipefail

echo "[KSTARS] Installing KStars & Ekos"

export DEBIAN_FRONTEND=noninteractive

# Sanity check: INDI should exist
if ! command -v indiserver >/dev/null 2>&1; then
    echo "[ERROR] INDI not found. Install INDI before KStars."
    exit 1
fi

apt update

# Core KStars + Ekos
apt install -y \
    kstars \
    kstars-data \
    kstars-bleeding \
    kde-runtime \
    qtwayland5 \
    qtbase5-dev \
    qml-module-qtquick-controls \
    qml-module-qtquick-controls2 \
    qml-module-qtgraphicaleffects \
    breeze-icon-theme \
    oxygen-icon-theme

echo "[KSTARS] Ensuring OpenGL compatibility"

# Mesa is critical for ARM + Wayland
apt install -y \
    mesa-utils \
    libgl1-mesa-dri \
    libgl1-mesa-glx

echo "[KSTARS] Creating default Ekos configuration directory"

EKOS_DIR="/etc/skel/.local/share/kstars"
mkdir -p "$EKOS_DIR"

echo "[KSTARS] Installation complete"

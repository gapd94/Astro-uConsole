#!/usr/bin/env bash
set -euo pipefail

echo "[PHD2] Installing PHD2 Guiding"

export DEBIAN_FRONTEND=noninteractive

# Sanity checks
if ! command -v indiserver >/dev/null 2>&1; then
    echo "[ERROR] INDI not found. Install INDI before PHD2."
    exit 1
fi

if ! command -v kstars >/dev/null 2>&1; then
    echo "[WARN] KStars not found. PHD2 can still run standalone."
fi

apt update

echo "[PHD2] Installing dependencies"

apt install -y \
    phd2 \
    phd2-data \
    wxgtk3.2 \
    libopencv-core-dev \
    libopencv-imgproc-dev \
    libcfitsio-dev \
    libusb-1.0-0 \
    libnova-0.16

echo "[PHD2] Installation complete"
echo "[PHD2] You can run PHD2 using the command 'phd2' in the terminal."
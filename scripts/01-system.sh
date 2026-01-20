#!/usr/bin/env bash
set -euo pipefail

echo "[SYSTEM] Installing base packages"

export DEBIAN_FRONTEND=noninteractive

apt update

apt install -y \
    sudo \
    curl \
    wget \
    git \
    build-essential \
    cmake \
    pkg-config \
    ca-certificates \
    usbutils \
    udev \
    dialog \
    htop \
    neovim

echo "[SYSTEM] Base system packages installed"

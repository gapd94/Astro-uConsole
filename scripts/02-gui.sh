#!/usr/bin/env bash
set -euo pipefail

echo "[GUI] Ensuring X11 / Wayland components exist"

apt install -y \
    x11-xserver-utils \
    mesa-utils \
    qtwayland5 \
    qtbase5-dev

echo "[GUI] GUI baseline complete"

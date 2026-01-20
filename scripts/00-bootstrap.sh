#!/usr/bin/env bash
set -euo pipefail

echo "[BOOTSTRAP] Starting system validation"

# Root check
if [[ "$EUID" -ne 0 ]]; then
    echo "[ERROR] This installer must be run as root"
    exit 1
fi

# OS check
if [[ ! -f /etc/os-release ]]; then
    echo "[ERROR] Cannot determine OS"
    exit 1
fi

source /etc/os-release

if [[ "$ID" != "debian" ]]; then
    echo "[ERROR] Unsupported OS: $ID"
    exit 1
fi

if [[ "$VERSION_CODENAME" != "bookworm" ]]; then
    echo "[ERROR] Unsupported Debian version: $VERSION_CODENAME"
    exit 1
fi

echo "[BOOTSTRAP] Debian Bookworm confirmed"

# Architecture check
ARCH="$(uname -m)"
if [[ "$ARCH" != "aarch64" && "$ARCH" != "arm64" ]]; then
    echo "[WARN] Architecture $ARCH not officially tested"
else
    echo "[BOOTSTRAP] Architecture: $ARCH"
fi

# Disk space check (minimum 10GB)
AVAILABLE_GB=$(df / | awk 'NR==2 {print int($4/1024/1024)}')
if (( AVAILABLE_GB < 10 )); then
    echo "[ERROR] Less than 10GB available on root filesystem"
    exit 1
fi

echo "[BOOTSTRAP] Disk space OK (${AVAILABLE_GB}GB available)"

# Network check (non-fatal)
if ping -c1 -W1 8.8.8.8 >/dev/null 2>&1; then
    echo "[BOOTSTRAP] Network detected"
else
    echo "[BOOTSTRAP] No network detected (offline mode)"
fi

# Logging directory
mkdir -p /var/log/astro-uconsole
chmod 755 /var/log/astro-uconsole

echo "[BOOTSTRAP] Completed successfully"

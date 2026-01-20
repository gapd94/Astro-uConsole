#!/usr/bin/env bash
set -euo pipefail

echo "[INDI] Hybrid installation starting"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${INDI_CORE_SOURCE:-false}" == "true" ]]; then
    echo "[INDI] Core: source build"
    "$SCRIPT_DIR/indi-core.sh" source
else
    echo "[INDI] Core: APT"
    "$SCRIPT_DIR/indi-core.sh" apt
fi

if [[ "${INDI_3RDPARTY_SOURCE:-true}" == "true" ]]; then
    echo "[INDI] 3rd Party: source build"
    "$SCRIPT_DIR/indi-3rdparty.sh"
else
    echo "[INDI] 3rd Party: APT"
    apt install -y indi-full
fi

echo "[INDI] Hybrid installation complete"

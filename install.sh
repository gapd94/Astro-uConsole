#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="Astro-uConsole"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_DIR="$BASE_DIR/config"
SCRIPT_DIR="$BASE_DIR/scripts"
LOG_DIR="/var/log/astro-uconsole"

# Load configuration
if [[ -f "$CONFIG_DIR/system.conf" ]]; then
    source "$CONFIG_DIR/system.conf"
else
    echo "[ERROR] system.conf not found"
    exit 1
fi

# Ensure log directory exists
sudo mkdir -p "$LOG_DIR"
sudo chmod 755 "$LOG_DIR"

LOG_FILE="$LOG_DIR/install-$(date +%Y%m%d-%H%M%S).log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "=========================================="
echo "$PROJECT_NAME installer started"
echo "Log file: $LOG_FILE"
echo "=========================================="

run_script() {
    local script="$1"
    echo
    echo "---- Running $script ----"
    if [[ ! -x "$SCRIPT_DIR/$script" ]]; then
        echo "[ERROR] Script $script not found or not executable"
        exit 1
    fi
    "$SCRIPT_DIR/$script"
}

run_script "00-bootstrap.sh"
run_script "01-system.sh"

if [[ "${ENABLE_GUI:-true}" == "true" ]]; then
    run_script "02-gui.sh"
fi

if [[ "${ENABLE_INDI:-true}" == "true" ]]; then
    run_script "astro/indi.sh"
fi

if [[ "${ENABLE_KSTARS:-true}" == "true" ]]; then
    run_script "astro/kstars-ekos.sh"
fi

echo
echo "=========================================="
echo "Astro-uConsole base installation complete"
echo "=========================================="

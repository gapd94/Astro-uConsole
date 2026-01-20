#!/usr/bin/env bash
set -euo pipefail

# Mock functions to simulate apt commands without actually installing
mock_apt() {
    echo "[MOCK] apt $@"
    # Simulate success
    return 0
}

mock_command() {
    if [[ "$1" == "-v" && "$2" == "indiserver" ]]; then
        echo "[MOCK] indiserver found"
        return 0
    else
        command "$@"
    fi
}

mock_mkdir() {
    echo "[MOCK] mkdir $@"
    # Don't actually create, just echo
}

# Override commands
apt() { mock_apt "$@"; }
command() { mock_command "$@"; }
mkdir() { mock_mkdir "$@"; }

# Source the original script
source /workspaces/Astro-uConsole/scripts/astro/kstars-ekos.sh

echo "[VERIFICATION] Script ran successfully in mock mode"
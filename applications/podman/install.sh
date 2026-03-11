#!/bin/bash
set -euo pipefail

if [[ "$(uname)" == "Darwin" ]]; then
    if [[ ! -e "/Library/LaunchDaemons/com.github.containers.podman.helper-${USER}.plist" ]]; then
        if command -v podman-mac-helper &>/dev/null; then
            sudo podman-mac-helper install
        else
            echo "  Skipping: podman-mac-helper not found"
        fi
    fi
fi

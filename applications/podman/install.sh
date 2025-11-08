#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ "$(uname)" == "Darwin" ]]; then
    if [[ ! -e "/Library/LaunchDaemons/com.github.containers.podman.helper-$USER.plist" ]]; then
        sudo podman-mac-helper install
    fi
fi

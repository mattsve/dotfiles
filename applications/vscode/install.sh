#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "  Skipping VSCode settings: unsupported platform"
    exit 0
fi

SETTINGS_FILE="$HOME/Library/Application Support/Code/User/settings.json"
mkdir -p "$(dirname "$SETTINGS_FILE")"
if [[ ! -L "$SETTINGS_FILE" ]]; then
    rm -f "$SETTINGS_FILE"
    ln -s "${SCRIPT_DIR}/settings.json" "$SETTINGS_FILE"
fi

append_if_missing "${HOME}/.zshenv" 'export EDITOR="code --wait"'

#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SETTINGS_FILE="";
if [[ "$(uname)" == "Darwin" ]]; then
    SETTINGS_FILE="$HOME/Library/Application Support/Code/User/settings.json"
fi

mkdir -p "$(dirname "$SETTINGS_FILE")"
if [[ ! -L "$SETTINGS_FILE" ]]; then
    rm -f "$SETTINGS_FILE"
    ln -s "${SCRIPT_DIR}/settings.json" "$SETTINGS_FILE"
fi

if [[ ! -f "${HOME}/.zshenv" ]]; then
    touch "${HOME}/.zshenv"
fi
if ! grep -Fxq 'export EDITOR="code --wait"' "${HOME}/.zshenv"; then
    echo 'export EDITOR="code --wait"' >> "${HOME}/.zshenv"
fi


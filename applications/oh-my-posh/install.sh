#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ! -f "${HOME}/.zshrc" ]]; then
    touch "${HOME}/.zshrc"
fi

CONFIGURATION="${SCRIPT_DIR}/configuration.omp.json"
if ! grep -Fxq "eval \"\$(oh-my-posh init zsh --config \"${CONFIGURATION}\")\"" "${HOME}/.zshrc"; then
    echo "eval \"\$(oh-my-posh init zsh --config \"${CONFIGURATION}\")\"" >> "${HOME}/.zshrc"
fi
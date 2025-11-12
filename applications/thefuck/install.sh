#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIGURATION="${SCRIPT_DIR}/configuration.omp.json"

if [[ ! -f "${HOME}/.zshrc" ]]; then
    touch "${HOME}/.zshrc"
fi
if ! grep -Fxq "eval \$(thefuck --alias)" "${HOME}/.zshrc"; then
    echo "eval \$(thefuck --alias)" >> "${HOME}/.zshrc"
fi
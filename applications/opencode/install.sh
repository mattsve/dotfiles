#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ! -f "${HOME}/.zshenv" ]]; then
    touch "${HOME}/.zshenv"
fi
if ! grep -Fxq 'export OPENCODE_EXPERIMENTAL_PLAN_MODE=1' "${HOME}/.zshenv"; then
    echo 'export OPENCODE_EXPERIMENTAL_PLAN_MODE=1' >> "${HOME}/.zshenv"
fi

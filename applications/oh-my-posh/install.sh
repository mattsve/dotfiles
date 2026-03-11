#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

CONFIGURATION="${SCRIPT_DIR}/configuration.omp.json"

# Use a grep pattern that matches regardless of the config path prefix so that
# re-cloning the dotfiles to a different location does not produce duplicate lines.
if ! grep -Fq 'oh-my-posh init zsh --config' "${HOME}/.zshrc" 2>/dev/null; then
    append_if_missing "${HOME}/.zshrc" "eval \"\$(oh-my-posh init zsh --config '${CONFIGURATION}')\""
fi

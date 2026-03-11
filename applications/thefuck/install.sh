#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

# Guard the eval so a missing thefuck binary does not break zsh startup
append_if_missing "${HOME}/.zshrc" 'command -v thefuck &>/dev/null && eval "$(thefuck --alias)"'

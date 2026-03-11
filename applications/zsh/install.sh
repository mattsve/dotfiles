#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=../lib.sh
source "${SCRIPT_DIR}/../lib.sh"

# HOMEBREW_PREFIX may not be set if brew shellenv has not been sourced yet
HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

append_if_missing "${HOME}/.zshrc" 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh'

if ! grep -Fxq 'FPATH=$(brew --prefix)/share/zsh-completions:$FPATH' "${HOME}/.zshrc"; then
    append_if_missing "${HOME}/.zshrc" 'FPATH=$(brew --prefix)/share/zsh-completions:$FPATH'
    append_if_missing "${HOME}/.zshrc" 'autoload -Uz compinit'
    append_if_missing "${HOME}/.zshrc" 'compinit'
    rm -f "${HOME}/.zcompdump"
    chmod go-w "${HOMEBREW_PREFIX}/share"
    chmod -R go-w "${HOMEBREW_PREFIX}/share/zsh"
fi

append_if_missing "${HOME}/.zshenv" 'export XDG_CONFIG_HOME=$HOME/.config'
append_if_missing "${HOME}/.zshenv" 'export SSH_AUTH_SOCK=$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock'

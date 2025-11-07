#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ ! -f "${HOME}/.zshrc" ]]; then
    touch "${HOME}/.zshrc"
fi
if ! grep -Fxq 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' "${HOME}/.zshrc"; then
    echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "${HOME}/.zshrc"
fi

if ! grep -Fxq 'FPATH=$(brew --prefix)/share/zsh-completions:$FPATH' "${HOME}/.zshrc"; then
    echo 'FPATH=$(brew --prefix)/share/zsh-completions:$FPATH' >> "${HOME}/.zshrc"
    echo 'autoload -Uz compinit' >> "${HOME}/.zshrc"
    echo 'compinit' >> "${HOME}/.zshrc"
    rm -f "${HOME}/.zcompdump"
    chmod go-w "${HOMEBREW_PREFIX}/share"
    chmod -R go-w "${HOMEBREW_PREFIX}/share/zsh"
fi
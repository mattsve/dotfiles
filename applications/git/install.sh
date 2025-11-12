#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

touch "${HOME}/.gitconfig"
if ! grep -Fxq "[user]" "${HOME}/.gitconfig"; then
    {
    echo "[user]"
    echo "    name = Mattias Svensson"
    echo "    email = 190869+mattsve@users.noreply.github.com"
    } >> "${HOME}/.gitconfig"
fi

if ! grep -Fxq "[core]" "${HOME}/.gitconfig"; then
    {
        echo ""
        echo "[core]"
        echo '    sshCommand = "ssh -i \"~/.ssh/GitHub SSH Key.pub\""'
    } >> "${HOME}/.gitconfig"
fi

mkdir -p "${HOME}/.ssh"
if [[ ! -f "${HOME}/.ssh/GitHub SSH Key.pub" ]]; then
    op read "op://Private/GitHub SSH Key/public key" > "${HOME}/.ssh/GitHub SSH Key.pub"
fi
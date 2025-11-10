#!/bin/bash
set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ "$(uname)" == "Darwin" ]]; then
    if [[ ! -e "${HOME}/Library/Keyboard Layouts/Swerty.keylayout" ]]; then
        ln -s "${SCRIPT_DIR}/Swerty.keylayout" "${HOME}/Library/Keyboard Layouts/Swerty.keylayout"
        ln -s "${SCRIPT_DIR}/Swerty.icns" "${HOME}/Library/Keyboard Layouts/Swerty.icns"
    fi
fi

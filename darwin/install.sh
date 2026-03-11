#!/bin/bash
set -euo pipefail

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

if [[ ! -d "${HOME}/.dotfiles/" ]]; then
    /opt/homebrew/bin/brew install --cask 1password
    echo "Set up 1password and enable ssh agent"
    read -rp "Press enter to continue"
    git clone git@github.com:mattsve/dotfiles.git ~/.dotfiles

    echo "Run this command to add Homebrew to your PATH:"
    echo '    eval "$(/opt/homebrew/bin/brew shellenv)"'
    echo "Run this command to bootstrap the machine"
    echo '    ~/.dotfiles/darwin/install.sh'
    exit 0
fi

echo "Setting up sudo to use touch id"
if [[ ! -f "/etc/pam.d/sudo_local" ]]; then
    sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
fi

echo "Setting up rosetta"
if [[ ! -f "/Library/Apple/usr/libexec/oah/libRosettaRuntime" ]]; then
    softwareupdate --install-rosetta --agree-to-license
fi

echo "Installing brew packages"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
brew bundle install --file "${SCRIPT_DIR}/Brewfile"

"${SCRIPT_DIR}/../.config/install.sh"
"${SCRIPT_DIR}/../applications/install.sh"

"${SCRIPT_DIR}/../settings/install.sh"

echo "Setting up appearance"
if defaults read NSGlobalDomain AppleInterfaceStyle &>/dev/null; then
    defaults delete NSGlobalDomain AppleInterfaceStyle
    echo "  Deleted AppleInterfaceStyle"
fi
if defaults read NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically &>/dev/null; then
    defaults delete NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically
    echo "  Deleted AppleInterfaceStyleSwitchesAutomatically"
fi

echo "Setting up services"
brew services start borders

echo "Done!"

#!/bin/bash
set -u

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

if [[ ! -d "${HOME}/.dotfiles/" ]]; then
    /opt/homebrew/bin/brew install —cask 1password
    echo "Set upp 1password and enable ssh agent"
    read -p "Press enter to continue"
    git clone git@github.com:mattsve/dotfiles.git ~/.dotfiles 

    echo "Run this command to add Homebrew to your PATH:"
    echo '    eval "$(/opt/homebrew/bin/brew shellenv)"'
    echo "Run this command to bootstrap the machine"
    echo '    ~/.dotfiles/darwin/install.sh'
    exit 0;
fi

if [[ ! -f "/etc/pam.d/sudo_local" ]]; then
    sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
brew bundle install --file "${SCRIPT_DIR}/Brewfile"

"${SCRIPT_DIR}/../.config/install.sh"
"${SCRIPT_DIR}/../applications/install.sh"

echo "Setting up dock"
if ! defaults read com.apple.dock static-only &> /dev/null; then
    defaults write com.apple.dock static-only -bool true; killall Dock
fi

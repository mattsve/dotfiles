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

echo "Setting up dock"
KILL_DOCK=false
if [[ ! "$(defaults read com.apple.dock persistent-apps)" == "(
)" ]]; then
    defaults write com.apple.dock persistent-apps -array
    echo "  Cleared persistent apps"
    KILL_DOCK=true
fi
if ! defaults read com.apple.dock appswitcher-all-displays &> /dev/null; then
    defaults write com.apple.dock appswitcher-all-displays -bool true
    echo "  Enabled app switcher on all displays"
    KILL_DOCK=true
fi
if ! defaults read com.apple.dock show-recents &> /dev/null; then
    defaults write com.apple.dock show-recents -bool false
    echo "  Disabled recent applications"
    KILL_DOCK=true
fi
if $KILL_DOCK; then
    killall Dock
fi 

echo "Setting up services"
brew services start borders

echo "Done!"
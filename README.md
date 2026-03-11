# dotfiles

macOS setup automation. Installs tools, configures apps, and symlinks config files.

> **Note:** This setup is personal and tailored specifically to my own account and environment. It cannot be used as-is by anyone else.

## Install

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mattsve/dotfiles/refs/heads/main/darwin/install.sh)"
```

## What it does

1. Installs [Homebrew](https://brew.sh) if missing
2. Clones this repo to `~/.dotfiles`
3. Enables Touch ID for `sudo`
4. Installs Rosetta 2
5. Installs all packages, casks, and apps via `darwin/Brewfile`
6. Symlinks everything in `.config/` into `~/.config/`
7. Runs each app installer in `applications/`
8. Pulls secrets and config files from 1Password
9. Configures the Dock
10. Configure the touchpad

## Structure

```
darwin/         # Entry point — install.sh + Brewfile
.config/        # Config files symlinked to ~/.config/ (borders, gh, opencode, wezterm)
applications/   # Per-app setup scripts (git, zsh, vscode, oh-my-posh, podman, ...)
```

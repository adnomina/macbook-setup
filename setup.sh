#!/usr/bin/env bash

set -euo pipefail

# Symlink dotfiles with GNU Stow
echo "Symlinking dotfiles ..."
stow --target="$HOME" --dir=./dotfiles fish ghostty nvim zed starship aerospace wezterm karabiner

# Change shell to fish
echo "Configuring fish as default shell ..."
chsh -s "$(which fish)"

# Restart shell
exec fish

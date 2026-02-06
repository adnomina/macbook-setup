#!/usr/bin/env bash

set -euo pipefail

# Install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew ..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    eval "$(/opt/homebrew/bin/brew shellenv)"

    echo "Homebrew installed."
fi

# Disable Homebrew analytics
brew analytics off

# Install packages from Brewfile
if [[ -f ./Brewfile ]]; then
  echo "Installing packages from Brewfile ..."

  brew bundle --file=./Brewfile
else
  echo "Warning: Brewfile not found."
fi

# Symlink dotfiles with GNU Stow
echo "Symlinking dotfiles ..."
stow --target="$HOME" --dir=./dotfiles fish ghostty nvim zed

# Restart shell
exec fish

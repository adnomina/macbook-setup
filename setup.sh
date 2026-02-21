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
stow --target="$HOME" --dir=./dotfiles fish ghostty nvim zed tmux starship

# Add fish to list of standard shells if not already present
echo "Configuring fish as default shell ..."
FISH_PATH="$(which fish)"

if ! grep -qx "$FISH_PATH" /etc/shells; then
  echo "Adding fish to /etc/shells ..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

# Change shell to fish
chsh -s "$FISH_PATH"

# Restart shell
exec fish

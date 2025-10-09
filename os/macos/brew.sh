#!/usr/bin/env bash

# Install Homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update
brew update

# Install packages
brew install git wget curl tree htop tmux vim fzf ripgrep bat jq

echo "✓ Homebrew packages installed"

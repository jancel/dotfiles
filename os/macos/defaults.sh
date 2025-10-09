#!/usr/bin/env bash

# macOS defaults
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock autohide -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain KeyRepeat -int 2

echo "✓ macOS defaults set"

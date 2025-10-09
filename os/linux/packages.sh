#!/usr/bin/env bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        ubuntu|debian)
            sudo apt-get update
            sudo apt-get install -y git curl wget vim tmux htop tree
            ;;
        fedora|rhel)
            sudo dnf install -y git curl wget vim tmux htop tree
            ;;
        arch)
            sudo pacman -Syu --noconfirm git curl wget vim tmux htop tree
            ;;
    esac
fi

echo "✓ Linux packages installed"

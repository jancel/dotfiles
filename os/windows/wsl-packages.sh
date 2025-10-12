#!/usr/bin/env bash
# WSL-specific package installation

echo "Setting up WSL environment..."

# Detect WSL distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case $ID in
        ubuntu|debian)
            sudo apt-get update
            sudo apt-get install -y \
                git curl wget vim tmux htop tree \
                build-essential \
                zsh \
                wslu \
                unzip zip
            ;;
        fedora)
            sudo dnf install -y \
                git curl wget vim tmux htop tree \
                @development-tools \
                zsh \
                wslu \
                unzip zip
            ;;
        *)
            echo "Unsupported WSL distribution: $ID"
            exit 1
            ;;
    esac
fi

echo "✓ WSL packages installed"

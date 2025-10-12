#!/usr/bin/env bash
set -euo pipefail

ANTIGEN_DIR="${HOME}/.antigen"
ANTIGEN_FILE="${ANTIGEN_DIR}/antigen.zsh"

echo "Setting up Antigen..."

# Create antigen directory
mkdir -p "$ANTIGEN_DIR"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v brew &> /dev/null; then
        echo "Installing Antigen via Homebrew..."
        if ! brew list antigen &> /dev/null; then
            brew install antigen
        else
            echo "✓ Antigen already installed via Homebrew"
        fi

        # Create symlink to user's .antigen directory for consistency
        if [[ -f /usr/local/share/antigen/antigen.zsh ]]; then
            ln -sf /usr/local/share/antigen/antigen.zsh "$ANTIGEN_FILE"
        elif [[ -f /opt/homebrew/share/antigen/antigen.zsh ]]; then
            ln -sf /opt/homebrew/share/antigen/antigen.zsh "$ANTIGEN_FILE"
        fi
    else
        echo "Homebrew not found. Installing Antigen manually..."
        curl -L git.io/antigen > "$ANTIGEN_FILE"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if command -v apt-get &> /dev/null; then
        # Debian/Ubuntu
        echo "Installing Antigen via apt..."
        if ! dpkg -l | grep -q zsh-antigen; then
            sudo apt-get update
            sudo apt-get install -y zsh-antigen
            ln -sf /usr/share/zsh-antigen/antigen.zsh "$ANTIGEN_FILE"
        else
            echo "✓ Antigen already installed via apt"
        fi
    elif command -v yum &> /dev/null; then
        # RHEL/CentOS/Fedora
        echo "Installing Antigen manually (not available in yum)..."
        curl -L git.io/antigen > "$ANTIGEN_FILE"
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        echo "Installing Antigen via pacman..."
        if ! pacman -Qi antigen &> /dev/null; then
            sudo pacman -S --noconfirm antigen
            ln -sf /usr/share/zsh/scripts/antigen.zsh "$ANTIGEN_FILE"
        else
            echo "✓ Antigen already installed via pacman"
        fi
    else
        echo "Package manager not found. Installing Antigen manually..."
        curl -L git.io/antigen > "$ANTIGEN_FILE"
    fi
else
    # Fallback for other systems
    echo "Unknown OS. Installing Antigen manually..."
    curl -L git.io/antigen > "$ANTIGEN_FILE"
fi

# Verify installation
if [[ -f "$ANTIGEN_FILE" ]]; then
    echo "✓ Antigen installed successfully at $ANTIGEN_FILE"
else
    echo "✗ Failed to install Antigen"
    exit 1
fi

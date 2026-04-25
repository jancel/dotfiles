#!/usr/bin/env bash
set -euo pipefail

ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"

echo "Setting up Oh My Zsh..."

# Install Oh My Zsh (unattended; do not chsh, do not run zsh, keep existing .zshrc)
if [[ -d "$ZSH" ]]; then
    echo "✓ Oh My Zsh already installed at $ZSH"
else
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Custom plugin repos (name -> repo URL)
plugin_clone() {
    local name="$1"
    local url="$2"
    local dest="${ZSH_CUSTOM}/plugins/${name}"
    if [[ -d "$dest/.git" ]]; then
        echo "✓ ${name} already installed; updating..."
        git -C "$dest" pull --ff-only --quiet || echo "  (update failed, leaving as-is)"
    else
        echo "Installing ${name}..."
        git clone --depth=1 "$url" "$dest"
    fi
}

plugin_clone zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
plugin_clone zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions.git
plugin_clone zsh-completions         https://github.com/zsh-users/zsh-completions.git

echo "✓ Oh My Zsh setup complete"

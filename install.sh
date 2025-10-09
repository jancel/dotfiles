#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles..."

# Clone or update repo
if [[ -d "$DOTFILES_DIR" ]]; then
    cd "$DOTFILES_DIR" && git pull
else
    git clone "https://github.com/jancel/dotfiles.git" "$DOTFILES_DIR"
fi

# Backup existing files
mkdir -p "$BACKUP_DIR"
for file in .bashrc .zshrc .vimrc .tmux.conf .gitconfig .aliases; do
    [[ -f "${HOME}/${file}" ]] && cp "${HOME}/${file}" "$BACKUP_DIR/"
done

# Create symlinks
ln -sf "${DOTFILES_DIR}/config/shell/.bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_DIR}/config/shell/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_DIR}/config/shell/.aliases" "${HOME}/.aliases"
ln -sf "${DOTFILES_DIR}/config/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_DIR}/config/vim/.vimrc" "${HOME}/.vimrc"
ln -sf "${DOTFILES_DIR}/config/tmux/.tmux.conf" "${HOME}/.tmux.conf"

echo "✓ Dotfiles installed!"
echo "Restart your terminal or run: source ~/.bashrc"

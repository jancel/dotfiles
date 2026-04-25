#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if grep -qi microsoft /proc/version 2>/dev/null || [ -n "${WSL_DISTRO_NAME:-}" ]; then
            echo "wsl"
        else
            echo "linux"
        fi
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
echo "Installing dotfiles for ${OS}..."

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

# Backup existing VSCode config if it exists (OS-specific paths)
case "$OS" in
    macos)
        VSCODE_CONFIG_DIR="${HOME}/Library/Application Support/Code/User"
        ;;
    wsl|linux)
        VSCODE_CONFIG_DIR="${HOME}/.config/Code/User"
        ;;
esac

if [[ -d "$VSCODE_CONFIG_DIR" ]]; then
    [[ -f "${VSCODE_CONFIG_DIR}/settings.json" ]] && \
        cp "${VSCODE_CONFIG_DIR}/settings.json" "$BACKUP_DIR/"
    [[ -f "${VSCODE_CONFIG_DIR}/tasks.json" ]] && \
        cp "${VSCODE_CONFIG_DIR}/tasks.json" "$BACKUP_DIR/"
fi

# Setup Oh My Zsh
echo "Setting up Oh My Zsh..."
"${DOTFILES_DIR}/scripts/setup-omz.sh"

# Create symlinks
ln -sf "${DOTFILES_DIR}/config/shell/.bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_DIR}/config/shell/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_DIR}/config/shell/.aliases" "${HOME}/.aliases"
ln -sf "${DOTFILES_DIR}/config/git/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${DOTFILES_DIR}/config/vim/.vimrc" "${HOME}/.vimrc"
ln -sf "${DOTFILES_DIR}/config/tmux/.tmux.conf" "${HOME}/.tmux.conf"

# Create VSCode config symlinks (OS-specific)
case "$OS" in
    macos)
        VSCODE_USER_DIR="${HOME}/Library/Application Support/Code/User"
        VSCODE_CHECK_DIR="${HOME}/Library/Application Support/Code"
        ;;
    wsl|linux)
        VSCODE_USER_DIR="${HOME}/.config/Code/User"
        VSCODE_CHECK_DIR="${HOME}/.config/Code"
        ;;
esac

if [[ -d "$VSCODE_CHECK_DIR" ]] || [[ "$OS" == "wsl" ]]; then
    mkdir -p "$VSCODE_USER_DIR"
    ln -sf "${DOTFILES_DIR}/config/vscode/settings.json" "${VSCODE_USER_DIR}/settings.json"
    ln -sf "${DOTFILES_DIR}/config/vscode/tasks.json" "${VSCODE_USER_DIR}/tasks.json"
    echo "✓ VSCode configs linked"
fi

# Run OS-specific setup
case "$OS" in
    wsl)
        echo "Running WSL-specific setup..."
        if [[ -f "${DOTFILES_DIR}/os/windows/wsl-packages.sh" ]]; then
            bash "${DOTFILES_DIR}/os/windows/wsl-packages.sh"
        fi
        if [[ -f "${DOTFILES_DIR}/os/windows/wsl-config.sh" ]]; then
            bash "${DOTFILES_DIR}/os/windows/wsl-config.sh"
        fi
        ;;
    linux)
        if [[ -f "${DOTFILES_DIR}/os/linux/packages.sh" ]]; then
            bash "${DOTFILES_DIR}/os/linux/packages.sh"
        fi
        ;;
    macos)
        if [[ -f "${DOTFILES_DIR}/os/macos/brew.sh" ]]; then
            bash "${DOTFILES_DIR}/os/macos/brew.sh"
        fi
        if [[ -f "${DOTFILES_DIR}/os/macos/defaults.sh" ]]; then
            bash "${DOTFILES_DIR}/os/macos/defaults.sh"
        fi
        ;;
esac

echo "✓ Dotfiles installed!"
echo "Restart your terminal or run: source ~/.bashrc"

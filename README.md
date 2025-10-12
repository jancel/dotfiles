# Dotfiles

Personal dotfiles for Mac and Linux.

## Quick Installation

```bash
curl -fsSL https://raw.githubusercontent.com/jancel/dotfiles/main/install.sh | bash
```

## Manual Installation

```bash
git clone https://github.com/jancel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

## Features

- Cross-platform support (macOS and Linux)
- Automatic Antigen installation and Oh My Zsh setup
- Zsh plugins: git, docker, kubectl, syntax-highlighting, autosuggestions, and more
- Automatic backups before installation
- Easy symlink management

## Commands

- `make install` - Full installation with backup
- `make fast-update` - Quick update (no backup)
- `make update` - Pull from git and update
- `make backup` - Backup existing configs
- `make setup-antigen` - Install/update Antigen only
- `make clean` - Remove broken symlinks

## What Gets Installed

### Shell Configuration
- `.zshrc` with Antigen and Oh My Zsh
- `.bashrc` for bash users
- `.aliases` with common shortcuts

### Antigen & Oh My Zsh
The setup automatically installs Antigen and configures Oh My Zsh with these plugins:
- git, docker, kubectl, npm, node
- command-not-found, z
- zsh-syntax-highlighting
- zsh-autosuggestions
- zsh-completions

### Other Configs
- Git configuration (`.gitconfig`)
- Vim configuration (`.vimrc`)
- Tmux configuration (`.tmux.conf`)
- VSCode settings (if VSCode is installed)

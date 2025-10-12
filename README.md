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
- `make init-devcontainer` - Initialize devcontainer in current directory
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

## Dev Containers

A reusable Debian-based devcontainer configuration is included that can be quickly initialized in any project.

### Features
- Base Debian (bookworm-slim) image
- Zsh with Oh My Zsh pre-configured
- Common development tools (git, build-essential, curl, wget, etc.)
- Non-root user (vscode) with sudo access
- Automatic dotfiles integration via postCreateCommand

### Usage

Initialize a devcontainer in any project directory:

**Option 1: Using Make**
```bash
cd /path/to/your/project
make -C ~/.dotfiles init-devcontainer
```

**Option 2: Using the script directly**
```bash
cd /path/to/your/project
~/.dotfiles/scripts/init-devcontainer.sh
```

**Option 3: Using VS Code Task**
1. Open Command Palette (Cmd+Shift+P / Ctrl+Shift+P)
2. Select "Tasks: Run Task"
3. Choose "Initialize Dev Container"

After initialization, customize `.devcontainer/devcontainer.json` and `.devcontainer/Dockerfile` as needed, then reopen the project in the container via the Command Palette: "Dev Containers: Reopen in Container"

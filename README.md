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

A fully automated, reusable Debian-based devcontainer configuration that automatically installs your dotfiles using VS Code's built-in dotfiles support.

### Features
- Base Debian (bookworm-slim) image
- Zsh with Oh My Zsh pre-configured
- Common development tools (git, build-essential, curl, wget, etc.)
- Non-root user (vscode) with sudo access
- **Automatic dotfiles installation** - Uses VS Code's native dotfiles feature
- **Smart repository detection** - Uses `DOTFILES_REPO` environment variable if set, otherwise defaults to `https://github.com/jancel/dotfiles.git`
- **Auto-updates on rebuild** - Refreshes dotfiles when container is recreated

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

After initialization:
1. (Optional) Customize `.devcontainer/devcontainer.json` and `.devcontainer/Dockerfile`
2. Open Command Palette (Cmd+Shift+P / Ctrl+Shift+P)
3. Select "Dev Containers: Reopen in Container"

Your dotfiles will be **automatically cloned and installed** using VS Code's built-in dotfiles support!

### Customizing the Dotfiles Repository

The devcontainer uses VS Code's native dotfiles feature, which automatically detects:

1. **Environment variable**: If `DOTFILES_REPO` is set in your environment, it will use that
2. **VS Code settings**: Configure in VS Code settings: `dotfiles.repository`
3. **Default fallback**: Uses `https://github.com/jancel/dotfiles.git` if nothing else is configured

To use your own fork, set the environment variable:
```bash
export DOTFILES_REPO=https://github.com/yourusername/dotfiles.git
```

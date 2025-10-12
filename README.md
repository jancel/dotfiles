# Dotfiles

Personal dotfiles for macOS, Linux, and Windows (via WSL).

## Quick Installation

### macOS / Linux / WSL

```bash
curl -fsSL https://raw.githubusercontent.com/jancel/dotfiles/main/install.sh | bash
```

## Manual Installation

### macOS / Linux / WSL

```bash
git clone https://github.com/jancel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

### Windows (WSL Required)

**Prerequisites**: WSL 2 must be installed.

#### Quick Install from PowerShell

Run this in PowerShell (will install WSL if needed):

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jancel/dotfiles/main/os/windows/Install-WSLDotfiles.ps1" -OutFile "$env:TEMP\Install-WSLDotfiles.ps1"; & "$env:TEMP\Install-WSLDotfiles.ps1"
```

#### Manual WSL Installation

If WSL is not installed:

1. Open PowerShell as Administrator and run:
   ```powershell
   wsl --install
   ```

2. Restart your computer

3. Open your WSL distribution (Ubuntu, Debian, etc.) and run:
   ```bash
   git clone https://github.com/jancel/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   make install
   ```

The installation will automatically detect WSL and configure:
- WSL-specific packages (wslu for Windows interop)
- Windows integration aliases (explorer, powershell, cmd)
- Git credential manager integration with Windows
- VS Code WSL integration

See [os/windows/README.md](os/windows/README.md) for detailed Windows/WSL documentation.

## Features

- **Cross-platform support**: macOS, Linux, and Windows (via WSL)
- **Automatic OS detection**: Installs appropriate packages and configurations for your system
- **Antigen & Oh My Zsh**: Automatic installation and setup
- **Zsh plugins**: git, docker, kubectl, syntax-highlighting, autosuggestions, and more
- **Automatic backups**: Before installation
- **Easy symlink management**: Consistent configuration across all platforms
- **WSL integration**: Windows-specific aliases and VS Code integration

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
- VSCode settings (automatically detects macOS, Linux, or WSL paths)

## Private Configuration

Dotfiles includes a secure local-only configuration system for sensitive data that should never be committed or logged.

### Security Features

- **Never committed**: All files in `local/` are gitignored
- **No logging**: Content is never logged unless `DOTFILES_LOG_LEVEL=debug`
- **Local-only**: Changes stay on your machine only
- **Automatic sourcing**: Loaded automatically by shell configuration

### Quick Start

Create private configuration files in `~/.dotfiles/local/`:

```bash
# Add private environment variables
echo 'export GITHUB_TOKEN="your_token"' > ~/.dotfiles/local/local.env

# Add private aliases
echo 'alias myserver="ssh user@private.com"' > ~/.dotfiles/local/local.aliases

# Add private git config (name, email, signing key)
cp ~/.dotfiles/local/templates/local.gitconfig.example ~/.dotfiles/local/local.gitconfig
```

See [local/README.md](local/README.md) for detailed documentation and examples.

### Log Levels

Control logging verbosity with `DOTFILES_LOG_LEVEL`:

```bash
# No logging
export DOTFILES_LOG_LEVEL=none

# Errors only (default for private configs)
export DOTFILES_LOG_LEVEL=error

# Show info messages
export DOTFILES_LOG_LEVEL=info

# Debug mode (may expose sensitive data!)
export DOTFILES_LOG_LEVEL=debug
```

## Platform-Specific Features

### macOS
- Homebrew installation and package management
- macOS system defaults configuration
- Applications: git, wget, curl, tree, htop, tmux, vim, fzf, ripgrep, bat, jq

### Linux
- Package manager detection (apt, dnf, pacman)
- Essential development tools
- Applications: git, curl, wget, vim, tmux, htop, tree

### Windows (WSL)
- WSL-specific package installation (including wslu for Windows interop)
- Windows integration aliases: `explorer`, `powershell`, `cmd`, `winget`
- Git credential manager integration with Windows
- VS Code WSL integration with proper path detection
- Automatic Windows username and home directory detection

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

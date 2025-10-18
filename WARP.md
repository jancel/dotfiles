# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Development Commands

### Core Commands
- `make install` - Full installation with automatic backup of existing configs
- `make fast-update` - Quick update without backup (for development)
- `make update` - Pull latest changes from git and update configurations
- `make backup` - Create timestamped backup of existing dotfiles
- `make clean` - Remove broken symlinks from home directory

### Setup and Initialization
- `make setup-antigen` - Install or update Antigen zsh plugin manager
- `make init-local` - Initialize private local configuration system
- `make setup-github` - Interactive GitHub configuration setup
- `make init-devcontainer` - Initialize VS Code devcontainer in current directory

### Security and Verification
- `make verify-security` - Verify security configuration of local files
- `./scripts/secure-logger.sh` - Secure logging system respecting DOTFILES_LOG_LEVEL

### Testing Installation
```bash
# Test installation on different OS types
./install.sh  # Auto-detects macOS, Linux, or WSL

# Manual OS-specific testing
bash os/macos/brew.sh      # macOS package installation
bash os/linux/packages.sh  # Linux package installation  
bash os/windows/wsl-packages.sh  # WSL-specific packages
```

## Architecture Overview

### Cross-Platform Design
This is a cross-platform dotfiles system supporting macOS, Linux, and Windows (via WSL). The architecture uses automatic OS detection throughout the codebase to handle platform-specific configurations.

**OS Detection Logic:**
- Darwin systems → macOS
- Linux with Microsoft in /proc/version or WSL_DISTRO_NAME → WSL
- Other Linux systems → Linux
- Used in: `install.sh`, `Makefile`, and setup scripts

### Directory Structure
```
config/          # All configuration files organized by tool
├── devcontainer/ # VS Code devcontainer templates
├── git/         # Git configuration (.gitconfig)
├── shell/       # Shell configs (.zshrc, .bashrc, .aliases)
├── tmux/        # Tmux configuration
├── vim/         # Vim configuration
└── vscode/      # VS Code settings and tasks

os/              # OS-specific installation scripts
├── linux/       # Linux package installation
├── macos/       # macOS Homebrew and system defaults
└── windows/     # WSL-specific configuration and packages

scripts/         # Utility and setup scripts
├── setup-antigen.sh      # Zsh plugin manager setup
├── secure-logger.sh      # Logging system with privacy controls
├── init-local-config.sh  # Private config initialization
├── setup-github.sh       # GitHub configuration helper
└── verify-security.sh    # Security verification

local/           # Private configurations (git-ignored)
```

### Key Architectural Features

**1. Secure Local Configuration System**
- Files in `local/` directory are git-ignored for sensitive data
- `secure-logger.sh` provides logging with configurable privacy levels
- Automatic sourcing of local configs in shell startup
- Never commits or logs private data unless explicitly enabled

**2. Cross-Platform VSCode Integration**
- Platform-specific path detection for VSCode configuration
- macOS: `~/Library/Application Support/Code/User`
- Linux/WSL: `~/.config/Code/User`
- Automatic devcontainer initialization with dotfiles integration

**3. Antigen/Oh-My-Zsh Plugin System**
- Multi-platform Antigen installation (Homebrew, apt, pacman, manual)
- Consistent plugin loading: git, docker, kubectl, syntax-highlighting, autosuggestions
- Cross-platform Antigen path resolution

**4. Backup and Safety System**
- Timestamped backups before any installation
- Symlink-based configuration management
- Broken symlink cleanup functionality

### Development Workflow Integration

**Devcontainer Support:**
- Automated VS Code devcontainer setup with `make init-devcontainer`
- Uses VS Code's native dotfiles integration
- Respects `DOTFILES_REPO` environment variable for custom forks
- Debian-based container with pre-configured development tools

**GitHub Integration:**
- Interactive GitHub configuration via `make setup-github`
- Handles SSH key setup, GPG signing, and repository configuration
- Integrates with local private configuration system

### Security Considerations

**Log Level Controls:**
- `DOTFILES_LOG_LEVEL` environment variable (none, error, warn, info, debug)
- Private configs default to error-only logging
- Debug mode may expose sensitive data (explicitly documented)

**Private Data Handling:**
- All local configurations are git-ignored
- Secure sourcing functions prevent accidental logging
- Template system for common private configurations
- Never commits sensitive information

## OS-Specific Notes

### macOS
- Uses Homebrew for package management
- Includes system defaults configuration via `os/macos/defaults.sh`
- Handles both Intel (`/usr/local`) and Apple Silicon (`/opt/homebrew`) paths

### Linux
- Supports apt (Debian/Ubuntu), dnf (RHEL/Fedora), and pacman (Arch)
- Essential development tools installation
- Distribution-agnostic where possible

### Windows (WSL)
- Requires WSL 2 installation
- Windows-specific aliases for interoperability (`explorer`, `powershell`, `cmd`)
- Git credential manager integration with Windows
- Automatic Windows username and home directory detection
- Special handling for VS Code WSL integration
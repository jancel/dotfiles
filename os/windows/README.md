# Windows / WSL Setup

This directory contains Windows and WSL-specific configuration files.

## Prerequisites

Windows Subsystem for Linux (WSL) 2 must be installed.

## Installation Options

### Option 1: From PowerShell (Easiest)

Run this command in PowerShell:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jancel/dotfiles/main/os/windows/Install-WSLDotfiles.ps1" -OutFile "$env:TEMP\Install-WSLDotfiles.ps1"; & "$env:TEMP\Install-WSLDotfiles.ps1"
```

### Option 2: From WSL

If WSL is already installed and configured:

```bash
curl -fsSL https://raw.githubusercontent.com/jancel/dotfiles/main/install.sh | bash
```

### Option 3: Manual Installation in WSL

```bash
git clone https://github.com/jancel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

## What Gets Configured

### Packages
- `wslu` - WSL utilities for Windows integration
- Standard development tools (git, curl, wget, vim, tmux, etc.)
- Build essentials
- Zsh and Oh My Zsh

### Windows Integration
The WSL configuration includes aliases for common Windows commands:

- `explorer` - Open Windows File Explorer
- `powershell` - Run PowerShell from WSL
- `cmd` - Run Command Prompt from WSL
- `winget` - Use Windows Package Manager

### Git Integration
- Configured to use Windows Git Credential Manager
- Seamless authentication with GitHub, Azure DevOps, etc.

### VS Code Integration
- Automatically detects VS Code installation (Windows or WSL)
- Configures VS Code settings for WSL environment
- Enables `code` command in WSL terminal

## Files

- `wsl-packages.sh` - Installs WSL-specific packages
- `wsl-config.sh` - Configures WSL environment and Windows integration
- `Install-WSLDotfiles.ps1` - PowerShell script to bootstrap installation
- `README.md` - This file

## Troubleshooting

### WSL Not Installed

If WSL is not installed, run as Administrator in PowerShell:

```powershell
wsl --install
```

Then restart your computer.

### Default Shell Not Zsh

After installation, set zsh as your default shell:

```bash
chsh -s $(which zsh)
```

Then restart your WSL terminal.

### VS Code Not Detected

Make sure VS Code is installed on Windows with the WSL extension:

1. Install VS Code for Windows: https://code.visualstudio.com/
2. Install the "Remote - WSL" extension
3. Restart your WSL terminal

### Git Credential Manager Issues

If git credentials aren't working:

```bash
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager-core.exe"
```

## Additional Resources

- [WSL Documentation](https://docs.microsoft.com/en-us/windows/wsl/)
- [VS Code WSL Extension](https://code.visualstudio.com/docs/remote/wsl)
- [Windows Terminal](https://aka.ms/terminal) - Recommended for better WSL experience

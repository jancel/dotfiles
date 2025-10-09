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

## Commands

- `make install` - Full installation with backup
- `make fast-update` - Quick update (no backup)
- `make update` - Pull from git and update
- `make backup` - Backup existing configs
- `make clean` - Remove broken symlinks

.PHONY: all install fast-update backup symlinks clean update help init-devcontainer verify-security init-local setup-github

DOTFILES_DIR := $(HOME)/.dotfiles
BACKUP_DIR := $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)

# Detect OS
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	OS := macos
	VSCODE_USER_DIR := $(HOME)/Library/Application Support/Code/User
else ifeq ($(UNAME_S),Linux)
	ifneq (,$(wildcard /proc/version))
		IS_WSL := $(shell grep -qi microsoft /proc/version && echo 1 || echo 0)
		ifeq ($(IS_WSL),1)
			OS := wsl
		else
			OS := linux
		endif
	else
		OS := linux
	endif
	VSCODE_USER_DIR := $(HOME)/.config/Code/User
endif

all: install

install: backup setup-antigen symlinks
	@echo "✓ Installation complete"

fast-update: symlinks
	@echo "✓ Fast update complete"

backup:
	@mkdir -p $(BACKUP_DIR)
	@for file in .bashrc .zshrc .vimrc .tmux.conf .gitconfig; do \
		[ -e $(HOME)/$$file ] && cp -r $(HOME)/$$file $(BACKUP_DIR)/; \
	done || true
	@if [ -d "$(HOME)/Library/Application Support/Code/User" ]; then \
		[ -f "$(HOME)/Library/Application Support/Code/User/settings.json" ] && \
			cp "$(HOME)/Library/Application Support/Code/User/settings.json" $(BACKUP_DIR)/; \
		[ -f "$(HOME)/Library/Application Support/Code/User/tasks.json" ] && \
			cp "$(HOME)/Library/Application Support/Code/User/tasks.json" $(BACKUP_DIR)/; \
	fi || true
	@echo "✓ Backup complete"

setup-antigen:
	@echo "Setting up Antigen..."
	@$(DOTFILES_DIR)/scripts/setup-antigen.sh

symlinks:
	@ln -sf $(DOTFILES_DIR)/config/shell/.bashrc $(HOME)/.bashrc
	@ln -sf $(DOTFILES_DIR)/config/shell/.zshrc $(HOME)/.zshrc
	@ln -sf $(DOTFILES_DIR)/config/shell/.aliases $(HOME)/.aliases
	@ln -sf $(DOTFILES_DIR)/config/git/.gitconfig $(HOME)/.gitconfig
	@ln -sf $(DOTFILES_DIR)/config/vim/.vimrc $(HOME)/.vimrc
	@ln -sf $(DOTFILES_DIR)/config/tmux/.tmux.conf $(HOME)/.tmux.conf
	@mkdir -p "$(VSCODE_USER_DIR)"
	@ln -sf $(DOTFILES_DIR)/config/vscode/settings.json "$(VSCODE_USER_DIR)/settings.json"
	@ln -sf $(DOTFILES_DIR)/config/vscode/tasks.json "$(VSCODE_USER_DIR)/tasks.json"
	@echo "✓ VSCode configs linked ($(OS))"
	@echo "✓ Symlinks created"

clean:
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete
	@echo "✓ Cleaned"

update:
	@cd $(DOTFILES_DIR) && git pull origin main
	@$(MAKE) fast-update

init-devcontainer:
	@$(DOTFILES_DIR)/scripts/init-devcontainer.sh

verify-security:
	@$(DOTFILES_DIR)/scripts/verify-security.sh

init-local:
	@$(DOTFILES_DIR)/scripts/init-local-config.sh

setup-github:
	@$(DOTFILES_DIR)/scripts/setup-github.sh

help:
	@echo "Detected OS: $(OS)"
	@echo ""
	@echo "Commands:"
	@echo "  make install           - Full installation"
	@echo "  make fast-update       - Quick update"
	@echo "  make update            - Pull and update"
	@echo "  make backup            - Backup existing"
	@echo "  make setup-antigen     - Install/update Antigen"
	@echo "  make init-devcontainer - Initialize devcontainer in current directory"
	@echo "  make init-local        - Initialize local private configuration"
	@echo "  make setup-github      - Interactive GitHub configuration setup"
	@echo "  make verify-security   - Verify security configuration"
	@echo "  make clean             - Remove broken links"

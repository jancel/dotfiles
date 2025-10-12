.PHONY: all install fast-update backup symlinks clean update help init-devcontainer

DOTFILES_DIR := $(HOME)/.dotfiles
BACKUP_DIR := $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)

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
	@if [ -d "$(HOME)/Library/Application Support/Code" ]; then \
		mkdir -p "$(HOME)/Library/Application Support/Code/User"; \
		ln -sf $(DOTFILES_DIR)/config/vscode/settings.json "$(HOME)/Library/Application Support/Code/User/settings.json"; \
		ln -sf $(DOTFILES_DIR)/config/vscode/tasks.json "$(HOME)/Library/Application Support/Code/User/tasks.json"; \
		echo "✓ VSCode configs linked"; \
	fi
	@echo "✓ Symlinks created"

clean:
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete
	@echo "✓ Cleaned"

update:
	@cd $(DOTFILES_DIR) && git pull origin main
	@$(MAKE) fast-update

init-devcontainer:
	@$(DOTFILES_DIR)/scripts/init-devcontainer.sh

help:
	@echo "Commands:"
	@echo "  make install          - Full installation"
	@echo "  make fast-update      - Quick update"
	@echo "  make update           - Pull and update"
	@echo "  make backup           - Backup existing"
	@echo "  make setup-antigen    - Install/update Antigen"
	@echo "  make init-devcontainer - Initialize devcontainer in current directory"
	@echo "  make clean            - Remove broken links"

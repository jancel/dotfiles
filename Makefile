.PHONY: all install fast-update backup symlinks clean update help

DOTFILES_DIR := $(HOME)/.dotfiles
BACKUP_DIR := $(HOME)/.dotfiles_backup_$(shell date +%Y%m%d_%H%M%S)

all: install

install: backup symlinks
	@echo "✓ Installation complete"

fast-update: symlinks
	@echo "✓ Fast update complete"

backup:
	@mkdir -p $(BACKUP_DIR)
	@for file in .bashrc .zshrc .vimrc .tmux.conf .gitconfig; do \
		[ -e $(HOME)/$$file ] && cp -r $(HOME)/$$file $(BACKUP_DIR)/; \
	done || true
	@echo "✓ Backup complete"

symlinks:
	@ln -sf $(DOTFILES_DIR)/config/shell/.bashrc $(HOME)/.bashrc
	@ln -sf $(DOTFILES_DIR)/config/shell/.zshrc $(HOME)/.zshrc
	@ln -sf $(DOTFILES_DIR)/config/shell/.aliases $(HOME)/.aliases
	@ln -sf $(DOTFILES_DIR)/config/git/.gitconfig $(HOME)/.gitconfig
	@ln -sf $(DOTFILES_DIR)/config/vim/.vimrc $(HOME)/.vimrc
	@ln -sf $(DOTFILES_DIR)/config/tmux/.tmux.conf $(HOME)/.tmux.conf
	@echo "✓ Symlinks created"

clean:
	@find $(HOME) -maxdepth 1 -type l ! -exec test -e {} \; -delete
	@echo "✓ Cleaned"

update:
	@cd $(DOTFILES_DIR) && git pull origin main
	@$(MAKE) fast-update

help:
	@echo "Commands:"
	@echo "  make install     - Full installation"
	@echo "  make fast-update - Quick update"
	@echo "  make update      - Pull and update"
	@echo "  make backup      - Backup existing"
	@echo "  make clean       - Remove broken links"

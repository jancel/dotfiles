# Zsh configuration
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# Load Antigen (cross-platform)
if [[ -f "${HOME}/.antigen/antigen.zsh" ]]; then
    source "${HOME}/.antigen/antigen.zsh"
elif [[ -f /usr/local/share/antigen/antigen.zsh ]]; then
    source /usr/local/share/antigen/antigen.zsh
elif [[ -f /opt/homebrew/share/antigen/antigen.zsh ]]; then
    source /opt/homebrew/share/antigen/antigen.zsh
elif [[ -f /usr/share/zsh-antigen/antigen.zsh ]]; then
    source /usr/share/zsh-antigen/antigen.zsh
else
    echo "Warning: Antigen not found. Run ~/.dotfiles/scripts/setup-antigen.sh"
fi

# Load Oh My Zsh library
antigen use oh-my-zsh

# Load Oh My Zsh plugins
antigen bundle git
antigen bundle docker
antigen bundle kubectl
antigen bundle npm
antigen bundle node
antigen bundle command-not-found
antigen bundle z

# Load external plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# Load theme
antigen theme robbyrussell

# Apply Antigen configuration
antigen apply

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Aliases
[ -f ~/.aliases ] && source ~/.aliases

# Load secure logging system
if [ -f "${HOME}/.dotfiles/scripts/secure-logger.sh" ]; then
    source "${HOME}/.dotfiles/scripts/secure-logger.sh"
fi

# Load local-only private configurations (never logged or committed)
# These files are in .gitignore and only exist on your local machine
if [ -f "${HOME}/.dotfiles/scripts/secure-logger.sh" ]; then
    # Use secure sourcing with proper logging controls
    dotfiles_secure_source "${HOME}/.dotfiles/local/local.env" "local environment variables"
    dotfiles_secure_source "${HOME}/.dotfiles/local/local.aliases" "local aliases"
    dotfiles_secure_source "${HOME}/.dotfiles/local/local.zshrc" "local zsh configuration"
else
    # Fallback to basic sourcing if secure logger not available
    [ -f "${HOME}/.dotfiles/local/local.env" ] && source "${HOME}/.dotfiles/local/local.env"
    [ -f "${HOME}/.dotfiles/local/local.aliases" ] && source "${HOME}/.dotfiles/local/local.aliases"
    [ -f "${HOME}/.dotfiles/local/local.zshrc" ] && source "${HOME}/.dotfiles/local/local.zshrc"
fi

# Local overrides (legacy support)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jeff/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

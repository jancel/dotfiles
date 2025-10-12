# Bash configuration
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# History
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000

# Prompt
PS1='\[\033[01;34m\]\w\[\033[00m\] $ '

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
    dotfiles_secure_source "${HOME}/.dotfiles/local/local.bashrc" "local bash configuration"
else
    # Fallback to basic sourcing if secure logger not available
    [ -f "${HOME}/.dotfiles/local/local.env" ] && source "${HOME}/.dotfiles/local/local.env"
    [ -f "${HOME}/.dotfiles/local/local.aliases" ] && source "${HOME}/.dotfiles/local/local.aliases"
    [ -f "${HOME}/.dotfiles/local/local.bashrc" ] && source "${HOME}/.dotfiles/local/local.bashrc"
fi

# Local overrides (legacy support)
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jancel/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

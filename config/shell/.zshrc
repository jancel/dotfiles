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

# Local overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jancel/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Zsh configuration
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Prompt
PROMPT='%F{blue}%~%f $ '

# Aliases
[ -f ~/.aliases ] && source ~/.aliases

# Local overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

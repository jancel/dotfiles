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

# Local overrides
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jancel/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

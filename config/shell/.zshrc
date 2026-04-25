# Zsh configuration
export PATH=$HOME/bin:$HOME/.local/bin:$PATH
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
alias claude="claude --dangerously-skip-permissions --chrome --teammate-mode tmux"

# Oh My Zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# zsh-completions: extend fpath before compinit (which OMZ runs)
fpath+=("${ZSH}/custom/plugins/zsh-completions/src")

# zfunctions: autoload custom functions from ~/.zfunctions
# Drop a file named after the function (e.g. ~/.zfunctions/hello) into the
# directory; its contents become the function body. See dotfiles
# config/shell/zfunctions/README.md for details.
if [[ -d "${HOME}/.zfunctions" ]]; then
    fpath=("${HOME}/.zfunctions" $fpath)
    for _zf in "${HOME}/.zfunctions"/*(N.); do
        # Skip files with extensions (README.md, .gitkeep, etc.) — function
        # files are named exactly after the function with no extension.
        [[ "${_zf:t}" == *.* ]] && continue
        autoload -Uz "${_zf:t}"
    done
    unset _zf
fi

# Plugins (zsh-syntax-highlighting must be last)
plugins=(
  git
  docker
  kubectl
  npm
  node
  command-not-found
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [[ -d "$ZSH" ]]; then
    source "$ZSH/oh-my-zsh.sh"
else
    echo "Warning: Oh My Zsh not found at $ZSH. Run ~/.dotfiles/scripts/setup-omz.sh"
fi

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
export PATH="/Users/jancel/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jancel/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="/usr/local/opt/ruby@3.3/bin:$PATH"
export PATH="/usr/local/opt/ruby@3.3/bin:$PATH"

# OpenClaw Completion
source "/Users/jancel/.openclaw/completions/openclaw.zsh"

# Greet new interactive shells with a dad joke (no-op if not installed
# or if curl can't reach the joke service — see zfunctions/dadjoke).
[[ -r "${HOME}/.zfunctions/dadjoke" ]] && dadjoke

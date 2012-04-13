alias _='sudo'
alias df='df -h'
alias g='grep -i'
alias h='history|g'
alias rm='rm -i'
alias rmf='rm -f'
alias cp='cp -r'
alias mv='mv -i'
alias md='mkdir -p'
alias ls='ls -hBG'
alias l.='ls -d .*'
alias ..='cd ..;'
alias ...='cd ..;cd ..;'
alias psgrep='ps aux|grep'
alias k9='kill -9'
alias fn='find . -name'
alias ll='ls -alt'
alias rs='rails server thin --debugger'
alias rc='pry -r ./config/environment'
alias rg='rails generate'
alias ...='cd ../..'
alias b='bundle'
alias bi='b install'
alias bu='b update'
alias be='b exec'
alias bl='b list'
alias rdb='rake db:migrate && rake db:test:prepare'

set -o vi
[ -z "$TMUX" ] && export TERM=xterm-256color

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

[[ -s "/home/tmux/.rvm/scripts/rvm" ]] && source "/home/tmux/.rvm/scripts/rvm"

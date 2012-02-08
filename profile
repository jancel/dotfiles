alias f='dscacheutil -flushcache'
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
alias top='htop'
alias ..='cd ..;'
alias ...='cd ..;cd ..;'
alias psgrep='ps aux|grep'
alias k9='kill -9'
alias fn='find . -name'
alias ll='ls -al'
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

finder='open -a Finder'

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export VIM_APP_DIR="/usr/local/Cellar/macvim/7.3-64"
export EDITOR="mvim "
export CVSEDITOR="mvim "
export SVN_EDITOR="mvim "
export MERGE_TOOL=/usr/bin/opendiff
shopt -s histappend

# Colors from http://wiki.archlinux.org/index.php/Color_Bash_Prompt
# misc
NO_COLOR='\e[0m' #disable any colors
# regular colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
# emphasized (bolded) colors
EBLACK='\e[1;30m'
ERED='\e[1;31m'
EGREEN='\e[1;32m'
EYELLOW='\e[1;33m'
EBLUE='\e[1;34m'
EMAGENTA='\e[1;35m'
ECYAN='\e[1;36m'
EWHITE='\e[1;37m'
# underlined colors
UBLACK='\e[4;30m'
URED='\e[4;31m'
UGREEN='\e[4;32m'
UYELLOW='\e[4;33m'
UBLUE='\e[4;34m'
UMAGENTA='\e[4;35m'
UCYAN='\e[4;36m'
UWHITE='\e[4;37m'
# background colors
BBLACK='\e[40m'
BRED='\e[41m'
BGREEN='\e[42m'
BYELLOW='\e[43m'
BBLUE='\e[44m'
BMAGENTA='\e[45m'
BCYAN='\e[46m'
BWHITE='\e[47m'

COLOR1=$ECYAN

PS1="\n\[$EBLUE\]\u@\[$COLOR1\]\h:\[$UYELLOW\]\W\[$NO_COLOR\] \n→ "

set -o vi
PATH="$PATH:/Users/jancel/java/android/android-sdk-macosx_86"
[[ -s "/Users/jancel/.rvm/scripts/rvm" ]] && source "/Users/jancel/.rvm/scripts/rvm"

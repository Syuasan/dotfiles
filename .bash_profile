# .bash_profile

#Japanese
export LC_ALL=ja_JP.UTF-8

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH

#TERM
export TERM=xterm-256color

#Prompt Color
GREEN="\[\033[32m\]"
WHITE="\[\033[37m\]"
PURPLE="\[\033[35m\]"
PS1="$PURPLE[\w]$WHITE:"

#alias
alias h='history 25'
alias j='jobs -l'
alias sl='ls -l'
alias la='ls -lah'
alias lf='ls -FA'
alias ll='ls -lA'
alias less='less -r'
alias hg='history | grep'
alias tmux='tmux -u'



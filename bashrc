# Default configuration #######################################################
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000
HISTTIMEFORMAT=%F" "%T" "

# Custom configuration ########################################################

# command aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -lh'
alias la='ls -lAh'
alias l='ls -CF'

# English man pages are more recent and more complete
alias man="LANG=\"en_US.UTF-8\" man"
alias aptitude="LANG=\"en_US.UTF-8\" aptitude"
alias apt-cache="LANG=\"en_US.UTF-8\" apt-cache"
alias apt-get="LANG=\"en_US.UTF-8\" apt-get"
alias ..="cd .."
alias ...="cd ../.."
alias py='python3.2'
alias nonempty='egrep -v "^$|^#"'
alias c="clear"

# set up acroread as PDF viewer for running files from mc
export TEXDOC_VIEWER_PDF="(acroread %s) &"

# enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# path settings for python scripts, texlive and ruby RVM
PATH=$PATH:$HOME/python:/usr/local/texlive/2012/bin/x86_64-linux:$HOME/.rvm/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# show git branch if you are in git repo directory
# http://stackoverflow.com/questions/347901/what-git-features-can-help-me-be-more-productive
PS1='\u@\h \w$(__git_ps1 " (%s)")\$ '

# set up proper color scheme for tmux
export TERM='screen-256color'
export EDITOR=vim

# enable vi mode for command and history edition
set -o vi

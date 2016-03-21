# sensible bash defaults ######################################################
[ -e "${HOME}/.bash/bash-sensible/sensible.bash" ] && \
  source "${HOME}/.bash/bash-sensible/sensible.bash"

# fzf #########################################################################
[ -e "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"

# aliases #####################################################################
[ -e "${HOME}/.zsh/aliases" ] && source "${HOME}/.zsh/aliases"

alias ls='ls --color'
alias l='ls -ah'
alias ll='ls -lah'
alias lld='ls -lahd'
alias reload='source ~/.bashrc'
alias bashrc='vim ~/.bashrc'
alias np='ncmpcpp'
alias am='alsamixer'

# functions
[ -e "${HOME}/.zsh/functions" ] && source "${HOME}/.zsh/functions"

# prompt ######################################################################
[ -e "${HOME}/.bash/git-completion.bash" ] && \
  source "${HOME}/.bash/git-completion.bash"

PS1='${debian_chroot:+($debian_chroot)}\u@\[\033[01;31m\]\h\[\033[00m\]:$(tput sgr0)\w$(__git_ps1 " (%s)")$ '

# autojump ####################################################################
[ -e /usr/share/autojump/autojump.bash ] && \
  source /usr/share/autojump/autojump.bash

# lscolors ####################################################################
[ -e "${HOME}/.colors" ] && source "${HOME}/.colors"

# history settings ############################################################
[ -e "${HOME}/.bash/history.bash" ] && source "${HOME}/.bash/history.bash"

# go tools ####################################################################
[ -d /usr/local/go/bin ] && export PATH="${PATH}:/usr/local/go/bin"
if [ -d "${HOME}/go/bin" ]; then
  export PATH="${HOME}/go/bin:$PATH"
  export GOPATH="${HOME}/go"
fi

# use binary jo and not the autojump function
declare -f jo &>/dev/null && unset -f jo

export EDITOR=vim
set -o vi

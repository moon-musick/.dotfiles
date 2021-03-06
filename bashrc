# sensible bash defaults ######################################################
[ -e "${HOME}/.bash/bash-sensible/sensible.bash" ] && \
  source "${HOME}/.bash/bash-sensible/sensible.bash"

# fzf #########################################################################
[ -e "${HOME}/.fzf.bash" ] && source "${HOME}/.fzf.bash"

# aliases #####################################################################
[ -e "${HOME}/.zsh/aliases" ] && source "${HOME}/.zsh/aliases"

# bash-specific
alias reload='source ~/.bashrc'
alias bashrc='vim ~/.bashrc'

# functions
[ -e "${HOME}/.zsh/functions" ] && source "${HOME}/.zsh/functions"

# prompt ######################################################################
[ -e "${HOME}/.bash/git-completion.bash" ] && \
  source "${HOME}/.bash/git-completion.bash"

[ -e "${HOME}/.bash/git-prompt.sh" ] && \
  source "${HOME}/.bash/git-prompt.sh"

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

# fzf #########################################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# use binary jo and not the autojump function
declare -f jo &>/dev/null && unset -f jo

export EDITOR=vim
set -o vi

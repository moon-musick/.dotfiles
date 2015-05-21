# Path to your oh-my-zsh configuration.
ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=7

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git history-substring-search vi-mode autojump \
  cabal command-not-found docker gem git-extras httpie pep8 pip python \
  vagrant web-search taskwarrior \
  )

[ -e "${ZSH}" ] && source "${ZSH}/oh-my-zsh.sh"

# history stuff ###############################################################

alias history='fc -i -l 1'

# add commands to history immediately
setopt -o sharehistory

# enable timestamps in history
setopt EXTENDED_HISTORY
export HISTSIZE=200000
export SAVEHIST=200000

# HH settings
export HISTFILE=$HOME/.zsh_history
if [ $(command -v hh) ]; then
  bindkey -s "\C-t" "\C-u hh \n"
  export HH_CONFIG=hicolor
fi

# setup vi mode
bindkey -v
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -v "^R" history-incremental-search-backward
bindkey -a "^R" history-incremental-search-backward
bindkey -v "^S" history-incremental-search-forward
bindkey -a "^S" history-incremental-search-forward

# aliases #####################################################################

alias ack='ack-grep'
alias aptitude="LANGUAGE=en_US.UTF-8 aptitude"
alias apt-cache="LANG=en apt-cache"
alias apt-get="LANG=en apt-get"
alias man='LC_ALL=C man'
alias c='clear'
alias rb='rbenv'
alias h='history'

# shell usage without stderr redirection yields much errors
alias firefox='firefox 2>/dev/null'
alias evince='evince 2>/dev/null'
# custom logging function
alias sc='scratch'

# exports ####################################################################

export EDITOR='vim'
export TERM='screen-256color'

[ -e "${HOME}/.colors" ] && source "${HOME}/.colors"

# export MC_SKIN="$HOME/.mc/lib/mc-solarized/solarized.ini"

# functions ###################################################################

# custom help command for zsh builtins
help(){
  # Comment by original author:
  # This function used to call the "bash" builtin.
  # bash -c "help $@"
  # Better way: look it up in the man pages.
  # I often look up "test" which doesn't give a useful result,
  # so I added that as a special case.
  if [[ $1 == "test" ]]; then
    man --pager="less -p'^CONDITIONAL EXPRESSIONS$'" zshall
  else
    man --pager="less -p'^ *$@ '" zshall
  fi
}

function trash {
  rm -rf $HOME/.local/share/Trash/*
}

# find out which shell is in use
function shell {
  ps -p $$
}

# http://blog.patshead.com/2012/11/a-couple-of-useful-snippets-from-my-shell-config.html?r=related
webshare () {
  local SSHHOST=nx.lokis.in
  local WEBPORT=8080

  python -m SimpleHTTPServer &
  local PID=$!

  echo "http://${SSHHOST}:${WEBPORT}" | xclip
  echo -n "Press enter to stop sharing, "
  echo    "http://${SSHHOST}:${WEBPORT} copied to primary selection"
  /usr/bin/ssh -R ${WEBPORT}:127.0.0.1:8000 ${SSHHOST} 'read'
  kill $PID
}

function scratch {
  LOGFILE="$HOME/.scratch.log"

  case "${1}" in
    'i'|'init' )
      echo "----------------------------------------------------------------" \
        >> "${LOGFILE}"
      echo -e "$(date '+%F %T')\n" >> "${LOGFILE}"
      ;;
    'sh'|'show' )
      cat "${LOGFILE}"
      ;;
    'c'|'cancel' )
      sed -i '$ d' "${LOGFILE}"
      ;;
    'a'|'add' )
      shift
      echo "$(date '+%T'): ${@}" >> "${LOGFILE}"
      ;;
    * )
      echo "$(date '+%T'): ${@}" >> "${LOGFILE}"
      ;;
  esac
}

# powerline prompt ############################################################

export POWERLINE="$HOME/.powerline/powerline-shell/powerline-shell.py"

if [ -e "${POWERLINE}" ]; then
  function powerline_precmd() {
    export PS1="$(${POWERLINE} $? --shell zsh)"
  }

  function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
      if [ "$s" = "powerline_precmd" ]; then
        return
      fi
    done
    precmd_functions+=(powerline_precmd)
  }

  install_powerline_precmd
fi

# path configuration && various additional tools ##############################

export PATH=$PATH:/home/lucas/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/lucas/.local/bin:/usr/local/texlive/2013/bin/x86_64-linux

PERL_MB_OPT="--install_base \"/home/lucas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lucas/perl5"; export PERL_MM_OPT;

# RVM
# Load RVM into a shell session *as a function*
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/bin" ]] && export PATH=$PATH:$HOME/.rvm/bin

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# enable tmuxinator
[ -e "${HOME}/bin/tmuxinator.zsh" ] && source "${HOME}/bin/tmuxinator.zsh"

# Cabal (Haskell)
[ -e "${HOME}/.cabal/bin" ] && export PATH=${PATH}:/home/lucas/.cabal/bin

# virtualenv via pip
[ -f /usr/local/bin/virtualenvwrapper.sh ] \
  && (export WORKON_HOME && source /usr/local/bin/virtualenvwrapper.sh)

# GVM
# [ -e $HOME/.gvm/scripts/gvm ] && source $HOME/.gvm/scripts/gvm
# export GOPATH="${HOME}/go"

# NVM
# export NVM_DIR="/home/lucas/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# notify command
[ -e "${HOME}/.zsh/notifyosd.zsh" ] && . "${HOME}/.zsh/notifyosd.zsh"

# https://github.com/zsh-users/zsh-syntax-highlighting
[ -e "${HOME}/.zsh/zsh-syntax-highlighting" ] \
  && source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# . /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh

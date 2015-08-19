# Path to your oh-my-zsh configuration.
ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="pure"
ZSH_THEME=""

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
  cabal command-not-found docker gem git-extras go httpie pass pep8 pip python \
  vagrant web-search taskwarrior zsh-completions \
  )

[ -e "${ZSH}" ] && source "${ZSH}/oh-my-zsh.sh"

# history stuff ###############################################################

alias history='fc -i -l 1'

# add commands to history immediately
setopt -o sharehistory

# enable timestamps in history
setopt EXTENDED_HISTORY
export HISTSIZE=2000000
export SAVEHIST=2000000

# HH settings
export HISTFILE=$HOME/.zsh_history
if [ "$(command -v hh)" ]; then
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
alias nmcli='LANG=en nmcli'
alias c='clear'
alias rb='rbenv'
alias h='history'

# shell usage without stderr redirection yields much errors
alias firefox='firefox 2>/dev/null'
alias eog='eog 2>/dev/null'
alias evince='evince 2>/dev/null'
alias libreoffice='libreoffice 2>/dev/null'
# custom logging function
alias sc='scratch'
alias policy='apt-cache policy'
alias search='apt-cache search'
alias show='apt-cache show'
alias depends='apt-cache depends'
alias fsearch='apt-file search'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias upgrade='sudo apt-get update -qqy && sudo apt-get dist-upgrade'
alias aremove='sudo apt-get autoremove && sudo apt-get autoclean'
alias dgrep='dpkg -l | grep -i'
alias hgrep='history | grep -i'

# get rid of irrelevant error messages
alias rs='BROWSER=fx rainbowstream'

# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

alias gh='git hist'
alias grs='git remote show origin'
alias ghh='git hist | head'

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
  rm -rf "$HOME/.local/share/Trash/"*
}

# find out which shell is in use
function shell {
  ps -p $$
}

function mkcd {
  mkdir -p "$1" && cd "$1"
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
  kill "$PID"
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
    'clearlog' )
      cat /dev/null > "${LOGFILE}"
      ;;
    'a'|'add' )
      shift
      echo "$(date '+%T'): ${@}" >> "${LOGFILE}"
      ;;
    'h'|'help' )
      echo "Usage: ${0} init|show|cancel|add TEXT|clearlog"
      echo "Usage: ${0} i|sh|c|a TEXT"
      echo "Usage: ${0} TEXT"
      ;;
    * )
      echo "$(date '+%T'): ${@}" >> "${LOGFILE}"
      ;;
  esac
}

# select tmux session with fzf
function fs {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# select tmux pane with fzf
function ftpane {
  local panes current_window target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_window=$(tmux display-message  -p '#I')

  target=$(echo "$panes" | fzf) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

# fkill - kill process
function fkill {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

# interactive command selection
function run {
  exec $(ls ${=PATH//:/ } 2>/dev/null | sort -u | fzf)
}

# path configuration && various additional tools ##############################

export PATH=$PATH:/home/lucas/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/lucas/.local/bin:/usr/local/texlive/2014/bin/x86_64-linux

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
export GOPATH="${HOME}/go"
export PATH="${HOME}/go/bin:/usr/local/go/bin:${PATH}"

# NVM
# export NVM_DIR="/home/lucas/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# notify command
[ -e "${HOME}/.zsh/notifyosd.zsh" ] && . "${HOME}/.zsh/notifyosd.zsh"

[ -e "${HOME}/.zsh/opp.zsh/" ] && . "${HOME}/.zsh/opp.zsh/opp.zsh"
[ -e "${HOME}/.zsh/opp.zsh/" ] && . "${HOME}/.zsh/opp.zsh/opp/surround.zsh"

# https://github.com/zsh-users/zsh-syntax-highlighting
[ -e "${HOME}/.zsh/zsh-syntax-highlighting" ] \
  && source "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# fzf https://github.com/junegunn/fzf
export FZF_TMUX=0
export FZF_DEFAULT_OPTS='-x --color=16'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# custom prompt
if [ "${UID}" -eq 0 ]; then NCOLOR="red"; else NCOLOR="default"; fi

if [[ -z "${SSH_CLIENT}" ]]; then
  prompt_host=""
else
  prompt_host="%{$bg[green]$fg[white]%} $(hostname -s) %{$reset_color%} "
fi

PROMPT='${prompt_host}%{$fg[$NCOLOR]%}%3c%{$reset_color%}%{$fg[red]%}%(1j. %j.)%{$reset_color%} '
RPROMPT='%(?..[%{$fg[red]%}%?%{$reset_color%}])%{$fg[$NCOLOR]%}%p $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# load tools
autoload zmv
autoload zcalc
autoload -U compinit && compinit

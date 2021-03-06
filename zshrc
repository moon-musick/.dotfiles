# oh-my-zsh ###################################################################

ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME=""
DISABLE_AUTO_TITLE="true"
export UPDATE_ZSH_DAYS=7

plugins=(
  autojump \
  command-not-found \
  docker \
  git-extras \
  go \
  history-substring-search \
  httpie \
  pass \
  pep8 \
  pip \
  python \
  taskwarrior \
  vagrant \
  web-search \
  zsh-completions \
)

[ -e "${ZSH}" ] && source "${ZSH}/oh-my-zsh.sh"

# history settings ############################################################

alias history='fc -i -l 1'

# add commands to history immediately
setopt -o sharehistory

# enable timestamps in history
setopt EXTENDED_HISTORY
export HISTSIZE=2000000
export SAVEHIST=2000000

# path ########################################################################

export PATH=/home/lucas/.local/bin:/home/lucas/.cargo/bin:/home/lucas/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:

# source additional config files ##############################################

[ -f "${HOME}/.zsh/aliases" ]   && . "${HOME}/.zsh/aliases"
[ -f "${HOME}/.zsh/functions" ] && . "${HOME}/.zsh/functions"
[ -f "${HOME}/.zsh/prompt" ]    && . "${HOME}/.zsh/prompt"
[ -f "${HOME}/.zsh/addons" ]    && . "${HOME}/.zsh/addons"
[ -f "${HOME}/.zsh/vi-mode" ]   && . "${HOME}/.zsh/vi-mode"

# source host-specific config if present
[ -f "${HOME}/.zsh-hostconfig" ] && . "${HOME}/.zsh-hostconfig"

# exports #####################################################################

export EDITOR='vim'
export TERM='screen-256color'

# fzf https://github.com/junegunn/fzf
export FZF_TMUX=0
export FZF_DEFAULT_OPTS='-x --color=16'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load tools
autoload zmv
autoload zcalc
autoload -U compinit && compinit

# unset 'jo' (use the binary, not the autojump function)
declare -f jo &>/dev/null && unset -f jo

# misc settings ###############################################################

# use '#' in interactive shell
setopt interactivecomments

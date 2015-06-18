#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/xvzf/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# Load Bash It
[ -e "$BASH_IT/bash_it.sh" ] && source "$BASH_IT/bash_it.sh"

# custom history-related stuff ################################################

# do not log both duplicate commands and commands starting with space
HISTCONTROL=ignoreboth

HISTSIZE=1000000
HISTFILESIZE=1000000
# list EXACT commands to be ignored
HISTIGNORE="pwd:ls:ls -ll:ls -lah:ll:l:history:h:exit:cd:cd :clear:c:reload"
# add timestamps
HISTTIMEFORMAT=%F" "%T" "

# append commands to history immediately
# http://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -c; history -r"

# hh configuration
export HISTFILE=$HOME/.bash_history
# enable hh binding if command exists
command -v hh 2>&1 >/dev/null \
  && { bind '"\C-t": "/usr/bin/hh \C-j"' && export HH_CONFIG=hicolor; }

# powerline shell #############################################################

# enable powerline prompt
# export POWERLINE="$HOME/.powerline/powerline-shell/powerline-shell.py"

# if [ -e "${POWERLINE}" ]; then
#   function _update_ps1() {
#     export PS1="$(${POWERLINE} $? 2> /dev/null)"
#   }

#   export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

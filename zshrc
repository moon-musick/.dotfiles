# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

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
plugins=(git history-substring-search vi-mode)

source $ZSH/oh-my-zsh.sh
bindkey -v 
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
alias ack='ack-grep'
#export LM_COLORS="ow='01;47'"
export TERM='screen-256color'
source $HOME/.colors
export MC_SKIN="$HOME/.mc/lib/mc-solarized/solarized.ini"

# Customize to your needs...
export PATH=$PATH:/home/lucas/bin:/home/lucas/.rvm/gems/ruby-2.0.0-p0/bin:/home/lucas/.rvm/gems/ruby-2.0.0-p0@global/bin:/home/lucas/.rvm/rubies/ruby-2.0.0-p0/bin:/home/lucas/.rvm/bin:/home/lucas/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/lucas/python:/usr/local/texlive/2012/bin/x86_64-linux:/home/lucas/.local/bin:/home/lucas/python:/usr/local/texlive/2012/bin/x86_64-linux:/home/lucas/.rvm/bin:/home/lucas/.local/bin

export WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

function powerline_precmd() {
    export PS1="$(~/bin/colors/powerline-shell/powerline-shell.py $? --shell zsh)"
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

help(){ 
    #This function used to call the "bash" builtin. 
    #bash -c "help $@"
    #Better way: look it up in the man pages. I often look up "test" which doesn't give a usefull result,
    ##so I added that as a special case.
    if [[ $1 == "test" ]]; then
        man --pager="less -p'^CONDITIONAL EXPRESSIONS$'" zshall
    else
        man --pager="less -p'^ *$@ '" zshall
    fi
}

PATH=$PATH:/usr/local/texlive/2013/bin/x86_64-linux

export ANSIBLE_HOSTS=~/dev/ansible_hosts
cd ~/dev/ansible && source ./hacking/env-setup > /dev/null && 1

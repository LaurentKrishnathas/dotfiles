#!/usr/bin/env bash
print "START oh-my-zsh.bash"

# take a/b/c/d      :  will mkdir then cd
# command + click   : open url
# command -tab      : will list options, ex ls -
#
#set +u

[[ -s "$ZSH" ]] || echo error ZSH not set
#ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel9k/powerlevel9k"
[[ -z "$ZSH_THEME" ]] && export ZSH_THEME="random"
echo "theme set to $ZSH_THEME"

#set -u
plugins=()
plugins+=aws
plugins+=brew
plugins+=dirhistory
plugins+=docker
plugins+=docker-compose
plugins+=extract
plugins+=fasd
plugins+=helm
plugins+=git
plugins+=git-extras
plugins+=git-flow
plugins+=gitignore
plugins+=httpie
plugins+=kubectl
plugins+=mvn
plugins+=rsync
plugins+=svn
plugins+=sudo
plugins+=tmux
plugins+=terraform
plugins+=vagrant
plugins+=web-search
plugins+=wd
plugins+=zsh-completions
plugins+=zsh-syntax-highlighting
plugins+=zsh-autosuggestions


plugins+=colorize
plugins+=colored-man-pages
plugins+=gradle


#expand aliases
#plugins+=globalias

echo "loading $ZSH/oh-my-zsh.sh ..."
source $ZSH/oh-my-zsh.sh
#source $SHELL_SCRIPT_BASEDIR/prompt.bash

print "END oh-my-zsh.bash"


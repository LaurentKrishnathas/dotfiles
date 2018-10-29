#!/usr/bin/env bash
export PROJECT_DIR=$HOME/code
export GITHUB_DIR=$HOME/code/github.com

export DOTFILES_DIR="$(GITHUB_DIR)/dotfiles.git"

export SHELL_SCRIPT_BASEDIR="$DOTFILES_DIR/bash"

source $SHELL_SCRIPT_BASEDIR/envs.bash

source $SHELL_SCRIPT_BASEDIR/variables.bash
source $SHELL_SCRIPT_BASEDIR/aliases.bash
source $SHELL_SCRIPT_BASEDIR/functions.bash
source $SHELL_SCRIPT_BASEDIR/functions/dockerfunctions.bash

# virtualenvwrapper settings
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh || echo ERROR virtualenvwrapper

# sdkmanfu	
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh" || echo ERROR sdkman

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh || echo ERROR autojump

# marker https://github.com/pindexis/marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh" || echo ERROR marker

# autoenv
[[ -s "/usr/local/opt/autoenv/activate.sh" ]] && source "/usr/local/opt/autoenv/activate.sh" || echo ERROR activate

# commacd not supported in zsh
[[ -s "$HOME/.commacd.bash" ]] && source "$HOME/.commacd.bash" || echo ERROR commacd


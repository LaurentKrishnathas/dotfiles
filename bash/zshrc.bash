#!/usr/bin/env bash
print "loading `pwd`/zshrc.bash  `date` version 2018-09-26 ..."
##################################################
#  
#
# @author Laurent Krishnathas
# @version 0.1
##################################################

source $HOME/code/src/github/dotfiles.git/bash/envs.bash

bashfile_array=()
bashfile_array+="$DOTFILES_DIR/bash/envs.bash"
bashfile_array+="$DOTFILES_DIR/bash/variables.bash"
bashfile_array+="$DOTFILES_DIR/bash/aliases.bash"


# Weird bug: alias need to be loaded before the tmux if check to make alias works.
for file in "${bashfile_array[@]}"
do
    if [ -s "$file" ]; then
        source $file
    else
        echo "ERROR $file missing"
        return 0
    fi
done

for file in `ls $SHELL_SCRIPT_BASEDIR/functions/*.bash`
do
    [[ -s "$file" ]] && source $file
done

PATH=$PATH:$HOME/.jenv/bin
PATH=$PATH:$HOME/.jenv/candidates/javadoc/current
PATH=$PATH:$HOME/.sdkman/candidates/java/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/groovy/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/grails/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/gradle/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/maven/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/springboot/current/bin
PATH=$PATH:$HOME/.sdkman/candidates/infrastructor/current/bin
PATH=$PATH:$HOME/Applications/packer
PATH=$PATH:/usr/local/Cellar/node/7.8.0/bin
PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
PATH=$PATH:$HOME/.vimpkg/bin
PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$HOME/bin:/bin:/bin:/bin

export PATH

if [ ! -z "$TMUX" ]; then
    echo "tmux detected."
    [[ -s "$ohmyzsh_file" ]] && echo "source $ohmyzsh_file" && source $ohmyzsh_file
    echo "Warning: skipping loading other tools in tmux mode."
else
    echo "no tmux detected"

    #no idea what this !!!
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


    bashfile_array=()
    bashfile_array+="$SHELL_SCRIPT_BASEDIR/variables.bash"
    bashfile_array+="$HOME/.init.bash"
    bashfile_array+="$ohmyzsh_file"
    bashfile_array+="$HOME/.sdkman/bin/sdkman-init.sh"
    bashfile_array+="$HOME/.jenv/bin/jenv-init.sh"
    bashfile_array+="$HOME/.jenv/commands/completion.sh"
    bashfile_array+="$HOME/gits/zaw.git/zaw.zsh"

    for file in "${bashfile_array[@]}"
    do
        if [ -s "$file" ]; then
            echo "source $file"
            source $file
        else
            echo "WARNING $file missing"
        fi
    done

    # loading jenkins autocomplete
    [[ -s "$DOTFILES_DIR/bash/jenkins.bash" ]] && echo "source jenkins autocomplete ..." && source $DOTFILES_DIR/bash/jenkins.bash autocomplete || echo "check $HOME/bin/jenkins symlink missing"
fi

# something overwrite key binding, so this is placed just before fzf
load_vi_mode

bashfile_array=()
bashfile_array+=$HOME/.fzf.zsh

for file in "${bashfile_array[@]}"
do
    if [ -s "$file" ]; then
        echo "source $file"
        source $file
    else
        echo "WARNING $file missing"
    fi
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh


unalias grv
#if [[ "$(ls -A ~/.dargs/completions/zsh)" ]];then
#  for f in ~/.dargs/completions/zsh/*;do source "$f";done
#fi

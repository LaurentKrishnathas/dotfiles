#!/usr/bin/env bash
##################################################
#
#
# @author Laurent Krishnathas
# @year 2019
# @version 0.1
##################################################
print "START envs.bash"

#missing in new mac
export DISPLAY=:0


# Used in functions
export PROJECT_DIR="$HOME/code"
export GITHUB_DIR="$PROJECT_DIR/github"
export GITLAB_DIR="$PROJECT_DIR/gitlab"

export DOTFILES_DIR="$GITHUB_DIR/dotfiles"

export SHELL_SCRIPT_BASEDIR="$DOTFILES_DIR/bash"
export TMUXINATOR_CONFIG=".tmuxinator" #making project specfic and local
export ohmyzsh_file="$SHELL_SCRIPT_BASEDIR/oh-my-zsh.bash"

export HOWTO_DIR="$GITLAB_DIR/howto.git"
export ZSH="$GITHUB_DIR/oh-my-zsh.git" #Needed for oh-my-zsh

# Java
export JDK_DIRS=/Library/Java/JavaVirtualMachines

export JDK6=$JDK_DIRS/1.6.0.jdk/Contents/Home
export JDK7=$JDK_DIRS/jdk1.7.0_80.jdk/Contents/Home
export JDK8=~/.sdkman/candidates/java/8.0.382.fx-zulu
export JDK11zulu=~/.sdkman/candidates/java/11.0.20.fx-zulu
export JDK11=$JDK_DIRS/amazon-corretto-11.jdk/Contents/Home

export JAVA_HOME=$JDK8

# Python
export WORKON_HOME=$HOME/.virtualenvs

# Golang removed as not used for a while, go run script.go is working
# export GOROOT="$HOME/Projects/github/go.git"
# export GOROOT_BOOTSTRAP="$HOME/Applications/go1.4.2.darwin-amd64-osx10.8/"
# export GOPATH="$HOME/Projects/goworkspace"

export PACKER_HOME="$HOME/Applications/packer"


export NPM_PACKAGES="${HOME}/.npm-packages" #npm was not using this env so hardcoded everywhere to make it user local and project local
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"



PATH=$PATH:/usr/local/opt/helm@2/bin:/usr/local/Cellar/subversion@1.8/1.8.19_1/bin/:$NPM_PACKAGES/node_modules/.bin
PATH=$PATH:~/bin:$GOROOT/bin:$GOPATH/bin:$MVN_HOME/bin:$ACTIVATOR_HOME:$PACKER_HOME:$HOME/Library/Python/2.7/bin
PATH=$PATH:/Applications/IntelliJ\ IDEA.app/Contents/MacOS
export PATH

print "END envs.bash"

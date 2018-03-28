#!/usr/bin/env bash
##################################################
# 
#
# @author Laurent Krishnathas
# @version 0.1
##################################################


# Used in functions
export PROJECT_DIR="$HOME/code/src"
export GITHUB_DIR="$PROJECT_DIR/github"
export GITLAB_DIR="$PROJECT_DIR/gitlab"

export DOTFILES_DIR="$GITHUB_DIR/dotfiles.git"

export SHELL_SCRIPT_BASEDIR="$DOTFILES_DIR/bash"
export TMUXINATOR_CONFIG=".tmuxinator" #making project specfic and local
export ohmyzsh_file="$SHELL_SCRIPT_BASEDIR/oh-my-zsh.bash"

export HOWTO_DIR="$GITLAB_DIR/howto.git"
export ZSH="$GITHUB_DIR/oh-my-zsh.git" #Needed for oh-my-zsh

# Java
export JDK6=/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JDK7=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export JDK8=/Library/Java/JavaVirtualMachines/jdk1.8.0_162.jdk/Contents/Home
export JDK9=/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home

export JAVA_HOME=$JDK9

# Python
export WORKON_HOME=$HOME/.virtualenvs

# Golang removed as not used for a while, go run script.go is working
# export GOROOT="$HOME/Projects/github/go.git"
# export GOROOT_BOOTSTRAP="$HOME/Applications/go1.4.2.darwin-amd64-osx10.8/"
# export GOPATH="$HOME/Projects/goworkspace"

export PACKER_HOME="$HOME/Applications/packer"

export PATH=$PATH:~/bin:$GOROOT/bin:$GOPATH/bin:$MVN_HOME/bin:$ACTIVATOR_HOME:$PACKER_HOME

export ECR_REGISTRY_URI="101999902141.dkr.ecr.eu-west-1.amazonaws.com"


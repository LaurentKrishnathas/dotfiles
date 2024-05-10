#!/usr/bin/env bash

set -x
set -u
set -e

GITHUB_DIR=$HOME/code/github
DOTFILES_DIR=$GITHUB_DIR/dotfiles

mkdir -p $GITHUB_DIR
[ ! -d "$DOTFILES_DIR" ]  && git clone https://github.com/LaurentKrishnathas/dotfiles $DOTFILES_DIR || echo "skip cloning"


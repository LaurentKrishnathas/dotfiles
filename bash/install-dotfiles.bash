#!/usr/bin/env bash


GITHUB_DIR=$$HOME/code/src/github.com
DOTFILES_DIR=$(GITHUB_DIR)/dotfiles.git

mkdir -p $(GITHUB_DIR)
[ ! -d "$(DOTFILES_DIR)" ]  && git clone https://github.com/LaurentKrishnathas/dotfiles.git $(DOTFILES_DIR) || echo "skip cloning"


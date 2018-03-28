#!/usr/bin/env bash
set -x

dir="$( cd "$(dirname "$0")" ; pwd -P )"
rm -rf ~/.tmux.conf
ln -s $dir/tmux.conf ~/.tmux.conf


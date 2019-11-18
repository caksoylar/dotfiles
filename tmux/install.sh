#!/bin/bash

mkdir -p ~/.tmux
ln -s "$(readlink -f $(dirname $0)/tmux.conf)" ~/.tmux/tmux.conf
ln -s $(readlink ~/.tmux/tmux.conf) ~/.tmux.conf

git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect
git clone --recursive https://github.com/Morantron/tmux-fingers ~/.tmux/plugins/tmux-fingers

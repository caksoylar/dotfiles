#!/bin/bash

mkdir -p ~/.config/tmux/plugins
ln -s "$(readlink -f $(dirname $0)/tmux.conf)" ~/.config/tmux/tmux.conf

# git clone https://github.com/tmux-plugins/tmux-resurrect ~/.config/tmux/plugins/tmux-resurrect
# git clone --recursive https://github.com/Morantron/tmux-fingers ~/.config/tmux/plugins/tmux-fingers

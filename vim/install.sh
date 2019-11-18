#!/bin/bash

ln -s "$(readlink -f $(dirname $0))" ~/.vim
mkdir -p ~/.vim/{temp,undo}

wget https://raw.githubusercontent.com/caksoylar/vim-jetpack/master/vjp -O ~/.vim/vjp
bash ~/.vim/vjp ~/.vim/plugins.txt ~/.vim/pack/remote

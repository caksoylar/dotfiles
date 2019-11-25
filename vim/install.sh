#!/bin/bash

ln -s "$(readlink -f $(dirname $0))" ~/.vim
mkdir -p ~/.vim/{temp,undo}

mkdir -p ~/.config/nvim
ln -s ~/.vim/init.vim ~/.config/nvim/

wget https://raw.githubusercontent.com/caksoylar/vim-jetpack/master/vjp -O ~/.vim/vjp
chmod u+x ~/.vim/vjp
~/.vim/vjp ~/.vim/plugins.txt ~/.vim/pack/remote

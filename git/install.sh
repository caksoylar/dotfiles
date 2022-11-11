#!/usr/bin/env bash

mkdir -p ~/.local/bin

wget https://raw.githubusercontent.com/ridiculousfish/git-prev-next/master/git-next -O ~/.local/bin/git-next
wget https://raw.githubusercontent.com/ridiculousfish/git-prev-next/master/git-prev -O ~/.local/bin/git-prev

ln -sf "$(readlink -f $(dirname $0))"/config ~/.gitconfig

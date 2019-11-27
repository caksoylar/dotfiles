#!/bin/bash

ln -s "$(readlink -f $(dirname $0))" ~/.config/kak
ln -s "$(readlink -f ~/.config/kak/kak-lsp)" ~/.config/kak-lsp

mkdir -p ~/.config/kak/autoload/remote

ln -s $(readlink -f "$(dirname $(type -p kak))"/../share/kak/autoload) ~/.config/kak/autoload/system
for url in \
    "https://raw.githubusercontent.com/alexherbo2/auto-pairs.kak/master/rc/auto-pairs.kak" \
    "https://raw.githubusercontent.com/Delapouite/kakoune-buffers/master/buffers.kak" \
    "https://raw.githubusercontent.com/chambln/kakoune-readline/master/readline.kak" \
    "https://gitlab.com/Screwtapello/kakoune-state-save/raw/master/state-save.kak" \
    "https://raw.githubusercontent.com/occivink/kakoune-vertical-selection/master/vertical-selection.kak"; do
    wget "$url" -O ~/.config/kak/autoload/remote/$(basename "$url")
done

# TODO: add kak-lsp

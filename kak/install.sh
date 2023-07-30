#!/usr/bin/env bash

ln -s "$(readlink -f $(dirname $0))" ~/.config/kak
ln -s "$(readlink -f ~/.config/kak/kak-lsp)" ~/.config/kak-lsp

mkdir -p ~/.config/kak/bundle

git clone https://github.com/jdugan6240/kak-bundle ~/.config/kak/bundle/kak-bundle

ln -s $(readlink -f "$(dirname $(type -p kak))"/../share/kak/autoload) ~/.config/kak/autoload/system

#!/usr/bin/env bash

ln -s "$(readlink -f $(dirname $0))" ~/.config/kak
ln -s "$(readlink -f ~/.config/kak/kak-lsp)" ~/.config/kak-lsp

mkdir -p ~/.config/kak/bundle/plugins

git clone https://codeberg.org/jdugan6240/kak-bundle ~/.config/kak/bundle/kak-bundle
git -C ~/.config/kak/bundle/kak-bundle switch big-rewrite

ln -s $(readlink -f "$(dirname $(type -p kak))"/../share/kak/autoload) ~/.config/kak/autoload/system

#!/usr/bin/env bash

ln -s "$(readlink -f $(dirname $0))" ~/.config/kak
ln -s "$(readlink -f ~/.config/kak/kak-lsp)" ~/.config/kak-lsp

mkdir -p ~/.config/kak/plugins

git clone https://github.com/andreyorst/plug.kak.git ~/.config/kak/plugins/plug.kak

ln -s $(readlink -f "$(dirname $(type -p kak))"/../share/kak/autoload) ~/.config/kak/autoload/system

#!/usr/bin/env bash

ln -s "$(readlink -f "$(dirname "$0")")" ~/.config/kak
ln -s "$(readlink -f ~/.config/kak/kak-lsp)" ~/.config/kak-lsp

ln -s "$(readlink -f "$(dirname "$(type -p kak)")/../share/kak/autoload")" ~/.config/kak/autoload/system

~/.config/kak/kjp ~/.config/kak/plugins.txt ~/.config/kak 8

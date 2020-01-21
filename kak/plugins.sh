#!/usr/bin/env bash

for url in \
    "https://raw.githubusercontent.com/alexherbo2/surround.kak/master/rc/surround.kak" \
    "https://raw.githubusercontent.com/Delapouite/kakoune-buffers/master/buffers.kak" \
    "https://raw.githubusercontent.com/chambln/kakoune-readline/master/readline.kak" \
    "https://gitlab.com/Screwtapello/kakoune-state-save/raw/master/state-save.kak" \
    "https://raw.githubusercontent.com/occivink/kakoune-vertical-selection/master/vertical-selection.kak"; do
    wget --hsts-file= -nv "$url" -O ~/.config/kak/autoload/remote/$(basename "$url")
done

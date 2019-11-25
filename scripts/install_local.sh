#!/bin/bash

# prerequisites: build-essential pkg-config

set -o errexit -o verbose

if [ -n "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.local/lib"
else
    export LD_LIBRARY_PATH="$HOME/.local/lib"
fi
export CPATH="$HOME/.local/include:$HOME/.local/include/ncursesw"
export PKG_CONFIG_PATH="$HOME/.local/share/pkgconfig"

install_libevent () {
    wget --hsts-file= -nv https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
    tar xzvf libevent-2.1.11-stable.tar.gz
    cd libevent-2.1.11-stable/
    ./configure -q --prefix="$HOME/.local"
    make -s -j8
    make -s install
    cd ..
}

install_ncurses () {
    wget --hsts-file= -nv https://invisible-mirror.net/archives/ncurses/ncurses-6.1.tar.gz
    tar xzvf ncurses-6.1.tar.gz
    cd ncurses-6.1
    ./configure -q --prefix="$HOME/.local" --with-shared --enable-pc-files --enable-widec --with-pkg-config-libdir="$HOME/.local/share/pkgconfig"
    make -s -j8
    make -s install
    cd ..
}

install_tmux () {
    wget --hsts-file= -nv https://github.com/tmux/tmux/releases/download/3.0/tmux-3.0-rc5.tar.gz
    tar xzvf tmux-3.0-rc5.tar.gz
    cd tmux-3.0-rc5
    ./configure -q CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncursesw" LDFLAGS="-L$HOME/.local/lib" LIBS=-lncursesw --prefix="$HOME/.local"
    make -s -j8
    make -s install
    cd ..
}

install_fish () {
    wget --hsts-file= -nv https://github.com/fish-shell/fish-shell/releases/download/3.0.2/fish-3.0.2.tar.gz
    tar xzvf fish-3.0.2.tar.gz
    cd fish-3.0.2/
    ./configure -q CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncursesw" LDFLAGS="-L$HOME/.local/lib" LIBS=-lncursesw --prefix="$HOME/.local"
    make -s -j8
    make -s install
    cd ..
}

install_nvim () {
    wget --hsts-file= -nv https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
    tar xzvf nvim-linux64.tar.gz --directory="$HOME/.local" --strip-components=1
}

install_kak () {
    git clone --quiet https://github.com/mawww/kakoune
    cd kakoune/
    PKG_CONFIG_PATH="$HOME/.local/share/pkgconfig" CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncursesw" LDFLAGS="-L$HOME/.local/lib" make -s -j8
    PREFIX=$HOME/.local make -s install
    cd ..
}

mkdir -p ~/src ~/.local
cd ~/src

if ! pkg-config --exists libevent; then
    install_libevent
fi

if ! pkg-config --exists ncursesw; then
    install_ncurses
fi

install_tmux

install_fish

install_nvim

install_kak

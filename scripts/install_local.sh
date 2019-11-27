#!/bin/bash

# prerequisites: build-essential pkg-config

mkdir -p ~/.local
cp "$(readlink -f $(dirname $0))"/Makefile.local ~/.local/Makefile

cd ~/.local
make

#!/bin/bash

set -e

cd ~
mkdir -p ~/.config/nvim/parser
rm -rf /tmp/tree-sitter-norg /tmp/tree-sitter-norg-meta

git clone --recursive https://github.com/nvim-neorg/tree-sitter-norg /tmp/tree-sitter-norg
cd /tmp/tree-sitter-norg
gcc -fPIC -Os -I./src -c src/parser.c -o parser.o
g++ -fPIC -Os -I./src -c src/scanner.cc -o scanner.o
g++ -shared -fPIC parser.o scanner.o -o ~/.config/nvim/parser/norg.so

git clone https://github.com/nvim-neorg/tree-sitter-norg-meta /tmp/tree-sitter-norg-meta
cd /tmp/tree-sitter-norg-meta
gcc -fPIC -Os -shared -I./src src/parser.c -o ~/.config/nvim/parser/norg_meta.so

cd ~
rm -rf /tmp/tree-sitter-norg /tmp/tree-sitter-norg-meta

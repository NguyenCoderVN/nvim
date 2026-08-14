#!/bin/bash

set -e

LAZY_DIR="$HOME/.local/share/nvim/lazy"
PARSER_DIR="$HOME/.local/share/nvim/site/parser"
TS_QUERIES_DIR="$LAZY_DIR/nvim-treesitter/runtime/queries"

mkdir -p "$PARSER_DIR"

# 1. Build norg.so
cd "$LAZY_DIR/tree-sitter-norg" || exit
gcc -fPIC -Os -I./src -c src/parser.c -o parser.o
g++ -fPIC -Os -I./src -c src/scanner.cc -o scanner.o
g++ -shared -fPIC parser.o scanner.o -o "$PARSER_DIR/norg.so"
rm -f parser.o scanner.o

# 2. Build norg_meta.so
cd "$LAZY_DIR/tree-sitter-norg-meta" || exit
gcc -fPIC -Os -shared -I./src src/parser.c -o "$PARSER_DIR/norg_meta.so"

# 3. Copy norg queries
cp -rf "$LAZY_DIR/neorg/queries/norg"* "$TS_QUERIES_DIR/"

cd ~ || exit

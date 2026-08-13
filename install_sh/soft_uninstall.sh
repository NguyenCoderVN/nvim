#!/bin/bash

# APT PACKAGES LIST
APT_PACKAGES=(
  nodejs npm python3-pip python3-venv
  build-essential liblua5.1-0-dev
  lua5.1 luarocks
  kitty wezterm
  ffmpeg fzf zoxide jq
  fd-find ripgrep
  imagemagick libmagickwand-dev texlive-latex-base
  xdg-utils xclip x11-apps
)

# NPM PACKAGES LIST
NPM_PACKAGES=(
  tree-sitter-cli
  @mermaid-js/mermaid-cli
)

echo "🗑️ Uninstalling NPM packages..."
if command -v npm &>/dev/null; then
  sudo npm uninstall -g "${NPM_PACKAGES[@]}"
fi

echo "🗑️ Uninstalling Python & Lua packages..."
python3 -m pip uninstall -y pynvim 2>/dev/null || true
luarocks remove magick --local 2>/dev/null || true

echo "🗑️ Uninstalling APT packages..."
sudo apt remove --purge -y "${APT_PACKAGES[@]}"
sudo apt autoremove -y

echo "🧹 Cleaning repository files..."
sudo rm -f /etc/apt/sources.list.d/wezterm.list
sudo rm -f /usr/share/keyrings/wezterm-fury.gpg
sudo rm -f /etc/apt/sources.list.d/debian.griffo.io.list
sudo rm -f /etc/apt/trusted.gpg.d/debian.griffo.io.gpg

echo "✅ Complete uninstallation process!"

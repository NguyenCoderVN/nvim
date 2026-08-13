#!/bin/bash

# CONFIGURATION
NVIM_VERSION="v0.12.3"
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
TMP_ARCHIVE="/tmp/nvim.tar.gz"
INSTALL_BASE_DIR="/opt"
EXTRACTED_DIR="${INSTALL_BASE_DIR}/nvim-linux-x86_64"
SYMLINK_PATH="/usr/local/bin/nvim"

echo "📦 Downloading Neovim ${NVIM_VERSION}..."
wget -q --show-progress "$DOWNLOAD_URL" -O "$TMP_ARCHIVE"

echo "⚙️ Extracting and linking binaries..."
sudo tar -C "$INSTALL_BASE_DIR" -xzf "$TMP_ARCHIVE"
sudo ln -sf "${EXTRACTED_DIR}/bin/nvim" "$SYMLINK_PATH"

rm -f "$TMP_ARCHIVE"

echo "✅ Neovim installed successfully!"
echo "🔍 Version Info:"
nvim --version | head -n 1b

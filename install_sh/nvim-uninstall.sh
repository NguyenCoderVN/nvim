#!/bin/bash

# PATHS TO CLEANUP
EXTRACTED_DIR="/opt/nvim-linux-x86_64"
SYMLINK_PATH="/usr/local/bin/nvim"
LOCAL_SHARE_DIR="$HOME/.local/share/nvim"

echo "🗑️ Uninstalling Neovim..."

# Delete installed binaries & symlink
sudo rm -rf "$EXTRACTED_DIR"
sudo rm -f "$SYMLINK_PATH"

# Delete runtime/data files
rm -rf "$LOCAL_SHARE_DIR"

echo "✅ Neovim has been uninstalled successfully!"

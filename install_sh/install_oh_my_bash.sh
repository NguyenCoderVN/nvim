#!/bin/bash

# 📌 CONFIGURATION VARIABLES
BASHRC_FILE="$HOME/.bashrc"
BASHRC_BACKUP="$HOME/.bashrc.pre-oh-my-bash"
OMB_DIR="$HOME/.oh-my-bash"
THEME_NAME="lambda"
THEME_FILE="$OMB_DIR/themes/$THEME_NAME/$THEME_NAME.theme.sh"
INSTALL_URL="https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh"

# 🗑️ STEP 1: CLEANUP (REMOVE OLD INSTALLATIONS)
echo "🗑️ Removing old Oh-My-Bash (if any)..."

# Remove old installation directory
rm -rf "$OMB_DIR"

# Restore original .bashrc if backup exists
if [ -f "$BASHRC_BACKUP" ]; then
    mv "$BASHRC_BACKUP" "$BASHRC_FILE"
fi

# 📦 STEP 2: INSTALLATION
echo "📦 Installing Oh-My-Bash..."
bash -c "$(curl -fsSL $INSTALL_URL)" --unattended

# 🎨 STEP 3: THEMING
echo "🎨 Setting theme to '$THEME_NAME'..."
sed -i "s/OSH_THEME=\".*\"/OSH_THEME=\"$THEME_NAME\"/" "$BASHRC_FILE"

echo "🛠️ Customizing '$THEME_NAME' theme (Hiding hostname)..."
# Check if the theme file exists before editing
if [ -f "$THEME_FILE" ]; then
    sed -i '/\$icon_host.*\\h/ s/^/# /' "$THEME_FILE"
else
    echo "⚠️  Warning: Theme file not found at $THEME_FILE"
fi

# ✅ FINALIZE
echo "✅ Oh-My-Bash installation complete!"
echo "🔄 Reloading bash environment..."

source "$BASHRC_FILE"

#!/bin/bash

BASHRC="$HOME/.bashrc"
OMB_DIR="$HOME/.oh-my-bash"
THEME="lambda"
THEME_FILE="$OMB_DIR/themes/$THEME/$THEME.theme.sh"

echo "📦 Installing Oh-My-Bash..."
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

echo "🎨 Configuring theme '$THEME'..."
sed -i "s/OSH_THEME=\".*\"/OSH_THEME=\"$THEME\"/" "$BASHRC"

[ -f "$THEME_FILE" ] && sed -i '/\$icon_host.*\\h/ s/^/# /' "$THEME_FILE"

echo "✅ Complete!."

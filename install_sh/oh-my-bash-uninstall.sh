#!/bin/bash

rm -rf ~/.oh-my-bash
BACKUP_FILE=$(ls -1t ~/.bashrc.omb-backup-* 2>/dev/null | head -n 1)

if [ -n "$BACKUP_FILE" ] && [ -f "$BACKUP_FILE" ]; then
    mv "$BACKUP_FILE" ~/.bashrc
else
    sed -i '/oh-my-bash/d' ~/.bashrc
fi

echo "✅ Removed Oh-My-Bash!"

#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# STEP 0: CLEANUP BROKEN REPOSITORIES
echo "🧹 Cleaning up broken third-party repositories..."
sudo rm -f /etc/apt/sources.list.d/debian.griffo.io.list /etc/apt/trusted.gpg.d/debian.griffo.io.gpg

# STEP 1: INSTALL BASIC UTILITIES
echo "🛠️ Installing basic tools..."
sudo apt update -y
sudo apt install -y curl gpg lsb-release wget tar

# APT PACKAGES LIST
APT_PACKAGES=(
  # System & Environment
  nodejs npm python3-pip python3-venv
  build-essential liblua5.1-0-dev
  lua5.1 luarocks

  # Terminals & CLI Utilities
  kitty wezterm
  ffmpeg fzf zoxide jq
  fd-find ripgrep

  # Media & Display
  imagemagick libmagickwand-dev texlive-latex-base
  xdg-utils xclip x11-apps
)

# NPM PACKAGES LIST
NPM_PACKAGES=(
  tree-sitter-cli
  @mermaid-js/mermaid-cli
)

# STEP 2: SETUP WEZTERM REPOSITORY
echo "🔑 Setting up WezTerm repository..."
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

# STEP 3: INSTALL APT PACKAGES
echo "📦 Installing APT packages..."
sudo apt update -y
sudo apt install -y "${APT_PACKAGES[@]}"

# STEP 4: INSTALL NPM PACKAGES
echo "📦 Installing NPM packages..."
sudo npm install -g "${NPM_PACKAGES[@]}"

# STEP 5: SETUP PYTHON ENVIRONMENT
echo "🐍 Installing Python dependencies..."
python3 -m pip install --user --upgrade pip pynvim --break-system-packages 2>/dev/null || python3 -m pip install --user --upgrade pip pynvim

# STEP 6: SETUP LUA ENVIRONMENT
echo "🌙 Installing Lua packages..."
luarocks install magick --local

# STEP 7: VERIFICATION & VERSION DISPLAY
echo -e "\n🔍 --- CHECKING INSTALLED VERSIONS ---"

check_cmd() {
    if command -v "$1" &>/dev/null; then
        echo -e "🏷️  $1: \033[0;32m$($2 2>&1 | head -n 1)\033[0m"
    else
        echo -e "❌ $1: \033[0;31mNot installed\033[0m"
    fi
}

echo -e "\n📦 System & Compilers:"
check_cmd "node" "node -v"
check_cmd "npm" "npm -v"
check_cmd "python3" "python3 --version"
check_cmd "gcc" "gcc --version"
check_cmd "lua" "lua -v"
check_cmd "luarocks" "luarocks --version"

echo -e "\n🚀 Terminals & CLI Utilities:"
check_cmd "kitty" "kitty --version"
check_cmd "wezterm" "wezterm --version"
check_cmd "fzf" "fzf --version"
check_cmd "zoxide" "zoxide --version"
check_cmd "jq" "jq --version"
check_cmd "fdfind" "fdfind --version"
check_cmd "rg" "rg --version"
check_cmd "ffmpeg" "ffmpeg -version"

echo -e "\n🖼️ Media & Tools:"
check_cmd "magick" "magick --version"
check_cmd "xclip" "xclip -version"
check_cmd "tree-sitter" "tree-sitter --version"
check_cmd "mmdc" "mmdc --version"

echo -e "\n🐍 Python Packages:"
if python3 -m pip show pynvim &>/dev/null; then
    echo -e "🏷️  pynvim: \033[0;32m$(python3 -m pip show pynvim | grep Version | cut -d' ' -f2)\033[0m"
else
    echo -e "❌ pynvim: \033[0;31mNot installed\033[0m"
fi

echo -e "\n🌙 Lua Rocks:"
if luarocks list --local 2>/dev/null | grep -q "magick"; then
    echo -e "🏷️  magick: \033[0;32mInstalled (local)\033[0m"
else
    echo -e "❌ magick: \033[0;31mNot installed\033[0m"
fi

echo -e "\n✅ Complete installation process!"

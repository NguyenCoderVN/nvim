#!/bin/bash

# 📌 CONFIGURATION & PACKAGE LISTS

# APT packages categorized by their use cases
APT_PACKAGES=(
  # --- 🛠️ Core Build Tools & Dependencies ---
  build-essential # GCC/G++ compilers and 'make' (required for compiling packages/plugins)
  liblua5.1-0-dev # Lua development headers (needed to compile C modules for Neovim/Lua)

  # --- 🌙 Lua Ecosystem (Crucial for Neovim) ---
  lua5.1   # Lua 5.1 runtime (Neovim uses LuaJIT which is 5.1 compatible)
  luarocks # Package manager for Lua modules

  # --- 🚀 Terminal Emulators ---
  kitty   # Fast, GPU-accelerated terminal emulator
  wezterm # Cross-platform, GPU-accelerated terminal (configured via Lua)

  # --- 📁 File Manager & Dependencies (Yazi) ---
  yazi          # Blazing fast terminal file manager with image preview
  ffmpeg        # Video thumbnails for Yazi
  poppler-utils # PDF previews for Yazi
  fzf           # Command-line fuzzy finder
  zoxide        # Smarter cd command
  jq            # JSON processor

  # --- 🔍 CLI Utilities (Used heavily by Neovim plugins like Telescope) ---
  fd-find # Extremely fast alternative to 'find' for file searching
  ripgrep # Extremely fast text search tool (grep alternative)

  # --- 🖼️ Media & Document Processing ---
  imagemagick        # Image manipulation tool (often used for terminal image previews)
  libmagickwand-dev  # ImageMagick C API headers (required for the Lua 'magick' rock)
  texlive-latex-base # Base LaTeX tools for rendering or compiling math/documents

  # --- 🖥️ System Utilities ---
  xdg-utils # Desktop integration (allows Neovim/Terminals to open URLs in your browser)
  xclip     # X11 clipboard interface (Crucial for Neovim clipboard support)
  x11-apps  # Standard X11 applications (Provides 'xclock')
)

NPM_PACKAGES=(
  tree-sitter-cli         # Required for compiling Tree-sitter parsers in Neovim
  @mermaid-js/mermaid-cli # CLI for generating diagrams from Mermaid code blocks
)

# 🔑 STEP 1: SETUP REPOSITORIES
echo "🔑 Setting up WezTerm repository..."
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list >/dev/null
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

echo "🔑 Setting up Yazi repository..."
curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list >/dev/null

# 🗑️ STEP 2: CLEANUP (UNINSTALL EXISTING)
echo "🗑️ Uninstalling existing packages to ensure a clean slate..."
sudo apt remove --purge -y "${APT_PACKAGES[@]}"
sudo apt autoremove -y
sudo npm uninstall -g "${NPM_PACKAGES[@]}"

# 📦 STEP 3: INSTALL FRESH PACKAGES
echo "📦 Installing fresh APT packages..."
sudo apt update
sudo apt install -y "${APT_PACKAGES[@]}"

echo "📦 Installing fresh NPM packages..."
sudo npm install -g "${NPM_PACKAGES[@]}"

# 🐍 STEP 4: PYTHON ENVIRONMENT SETUP
echo "🐍 Installing Python dependencies for Neovim..."
pip install --upgrade pip
python3 -m pip install --user pynvim

# 🌙 STEP 5: LUA ENVIRONMENT SETUP
echo "🌙 Installing Lua packages for Neovim..."
luarocks install magick --local

# 🔍 STEP 6: VERIFICATION
echo "🔍 --- CHECKING INSTALLED VERSIONS --- 🔍"

# Check APT Packages
for pkg in "${APT_PACKAGES[@]}"; do
  dpkg-query -W -f='🏷️  ${binary:Package}: ${Version}\n' "$pkg" 2>/dev/null || echo "❌ $pkg: Not installed"
done

# Check NPM Packages
for pkg in "${NPM_PACKAGES[@]}"; do
  npm -g list "$pkg" --depth=0 | grep -o "$pkg@.*" | sed 's/^/🏷️  /' || echo "❌ $pkg: Not installed"
done

# Check Lua Rocks
if luarocks list --local | grep -q "magick"; then
  echo "🏷️  luarocks: magick (installed)"
else
  echo "❌ luarocks: magick not installed"
fi

# ✅ FINALIZE
# Optional Image Tests (Uncomment to use)
# wezterm imgcat unsplash_image.jpg
# kitty icat unsplash_image.jpg
# yazi # Go ahead and try browsing to a folder with pictures!
# xclock & # Launch xclock in the background to test X11 apps

echo "✅ Clean installation complete! 🎉"

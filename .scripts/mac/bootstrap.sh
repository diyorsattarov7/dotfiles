#!/usr/bin/env bash
set -euo pipefail

echo "Installing required packages..."
brew install zsh gnupg tmux neovim

DOTFILES_DIR="$HOME/dotfiles"
echo "Creating symlinks..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.zshrc"        "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf"    "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.config/nvim"   "$HOME/.config/"

cat <<'MSG'

✅ Bootstrap (base) complete.

Next steps:
1) source .zshrc
2) Then run the post-setup script:
   ~/.scripts/mac/provision.sh

MSG

#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"

# Symlink each dotfile
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/config/nvim" "$HOME/.config/"

echo "✅ Symlinks created!"

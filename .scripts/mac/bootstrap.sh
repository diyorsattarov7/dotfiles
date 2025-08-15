#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Starting macOS bootstrap..."

if ! command -v brew >/dev/null 2>&1; then
    echo "❌ Homebrew is not installed. Please install it first:"
    echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

echo "Creating symlinks..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
source "$HOME/.zshrc"

echo "Installing required packages..."
brew install gnupg git tmux neovim

if ! grep -q "GPG_TTY" "$HOME/.zshrc" 2>/dev/null; then
    echo "Adding GPG_TTY to ~/.zshrc..."
    echo 'export GPG_TTY=$(tty)' >>"$HOME/.zshrc"
fi
source "$HOME/.zshrc"

echo "⚠️  You will now generate a GPG key."
gpg --full-generate-key

echo "📜 Your secret keys:"
gpg --list-secret-keys --keyid-format=long

echo "⚠️  Copy the KEY_ID from above."
read -rp "Paste your KEY_ID here: " KEY_ID
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "youremail@example.com"
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
    echo "📋 Public key (add to GitHub):"
    cat "${SSH_KEY}.pub"
    echo "Press Enter after adding the SSH key to GitHub..."
    read
    ssh -T git@github.com || true
else
    echo "✅ SSH key already exists"
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "To install tmux plugins: start tmux, then press Ctrl+b Shift+I"

echo "✅ Bootstrap complete!"

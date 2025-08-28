#!/usr/bin/env bash
set -euo pipefail

echo "Installing required packages..."
brew install zsh gnupg tmux neovim

DOTFILES_DIR="$HOME/dotfiles"
echo "Creating symlinks..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.zshrc"        "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf"    "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.config/nvim"  "$HOME/.config/"

echo
echo "=== GPG setup ==="
if gpg --list-secret-keys --keyid-format=long 2>/dev/null | grep -q '^sec'; then
    echo "GPG secret key(s) found:"
    gpg --list-secret-keys --keyid-format=long
else
    echo "No GPG secret key found. Generating..."
    gpg --full-generate-key
    echo "GPG secret key(s):"
    gpg --list-secret-keys --keyid-format=long
fi

echo -n "⚠️  Paste your GPG KEY_ID (e.g., ABCDEF1234567890): "
read KEY_ID

git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo -n "Enter your Git username: "
read GIT_USER
echo -n "Enter your Git email: "
read GIT_EMAIL
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

echo "📤 Exporting your GPG public key for GitHub..."
gpg --armor --export "$KEY_ID" >"$HOME/gpg_key.pub"
echo "✅ GPG public key saved to $HOME/gpg_key.pub"
echo "📋 Public GPG key (add this to GitHub GPG keys):"
cat "$HOME/gpg_key.pub"
echo

echo "=== SSH setup ==="
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo -n "Enter your email for the SSH key: "
    read SSH_EMAIL
    mkdir -p "$HOME/.ssh"
    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$SSH_KEY" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
    echo "📋 Public key (add to GitHub):"
    cat "${SSH_KEY}.pub"
    echo "Press Enter after adding the SSH key to GitHub..."
    read
    ssh -T git@github.com || true
else
    echo "✅ SSH key already exists at $SSH_KEY"
fi
echo

echo "=== Tmux Plugin Manager (TPM) ==="
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    echo "✅ TPM already installed"
fi
echo "To install tmux plugins: start tmux, then press Ctrl+b Shift+I"
echo

echo "=== Neovim packer.nvim ==="
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_DIR" ]; then
    echo "Installing packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
else
    echo "✅ packer.nvim already installed"
fi

cat <<'MSG'

✅ Bootstrap complete.

To finalize setup:
  1. source ~/.zshrc
  2. Open Neovim
  3. Run :PackerSync

MSG

#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

echo "=== Installing required packages ==="
brew install zsh gnupg tmux neovim

echo
echo "=== Creating symlinks ==="

mkdir -p "$HOME/.config"

ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

NVIM_CONFIG="$HOME/.config/nvim"

if [ -d "$NVIM_CONFIG" ] && [ ! -L "$NVIM_CONFIG" ]; then
    BACKUP="${NVIM_CONFIG}.backup.$(date +%Y%m%d%H%M%S)"
    echo "Backing up existing Neovim configuration to $BACKUP"
    mv "$NVIM_CONFIG" "$BACKUP"
fi

ln -sfn "$DOTFILES_DIR/.config/nvim" "$NVIM_CONFIG"

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

echo
read -r -p "Paste your GPG KEY_ID (e.g., ABCDEF1234567890): " KEY_ID

git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo
read -r -p "Enter your Git username: " GIT_USER
read -r -p "Enter your Git email: " GIT_EMAIL

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

echo
echo "=== Exporting GPG public key ==="

gpg --armor --export "$KEY_ID" > "$HOME/gpg_key.pub"

echo "GPG public key saved to $HOME/gpg_key.pub"
echo "Add the following key to GitHub under Settings > SSH and GPG keys:"
cat "$HOME/gpg_key.pub"

echo
echo "=== SSH setup ==="

SSH_KEY="$HOME/.ssh/id_ed25519"

if [ ! -f "$SSH_KEY" ]; then
    read -r -p "Enter your email for the SSH key: " SSH_EMAIL

    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$SSH_KEY" -N ""

    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"

    echo
    echo "SSH public key (add to GitHub):"
    cat "${SSH_KEY}.pub"

    echo
    read -r -p "Press Enter after adding the SSH key to GitHub..."

    ssh -T git@github.com || true
else
    echo "SSH key already exists at $SSH_KEY"
fi

echo
echo "=== Tmux Plugin Manager (TPM) ==="

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
    echo "TPM already installed"
fi

echo "To install tmux plugins: start tmux, then press Ctrl+b Shift+I"

echo
echo "=== Neovim ==="

echo "lazy.nvim will be installed automatically on first launch."
echo "Configured plugins will be installed by lazy.nvim."

cat <<'MSG'

Bootstrap complete.

To finalize setup:

  1. Restart your terminal or run:
     source ~/.zshrc

  2. Open Neovim:
     nvim

  3. Install or synchronize plugins:
     :Lazy sync

  4. Verify your configuration:
     :checkhealth

  5. Install tmux plugins:
     Start tmux and press Ctrl+b Shift+I

MSG

#!/usr/bin/env bash
set -euo pipefail

if ! command -v zsh >/dev/null 2>&1; then
    brew install zsh
    chsh -s "$(which zsh)"
fi

if [ -z "${BOOTSTRAP_IN_ZSH:-}" ]; then
    echo "🔄 Switching to zsh..."
    BOOTSTRAP_IN_ZSH=1 exec zsh "$0" "$@"
fi

echo "✅ Now running in zsh"
echo "ZSH version: $ZSH_VERSION"

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Starting macOS bootstrap..."

echo "Creating symlinks..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/config/nvim" "$HOME/.config/"

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ -d "/opt/homebrew/bin" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>"$HOME/.zshrc"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

echo "Installing required packages..."
brew install gnupg git tmux neovim

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo "✅ Default shell changed to zsh — you may need to log out and back in."
else
    echo "✅ Default shell already zsh"
fi

if ! grep -q "GPG_TTY" "$HOME/.zshrc" 2>/dev/null; then
    echo "Adding GPG_TTY to ~/.zshrc..."
    echo 'export GPG_TTY=$(tty)' >>"$HOME/.zshrc"
fi
source "$HOME/.zshrc"

echo "⚠️  You will now generate a GPG key."
gpg --full-generate-key

echo "📜 Your secret keys:"
gpg --list-secret-keys --keyid-format=long

echo -n "⚠️  Paste your KEY_ID here: "
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

SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo "Generating SSH key..."
    echo -n "Enter your email for the SSH key: "
    read SSH_EMAIL
    ssh-keygen -t ed25519 -C "$SSH_EMAIL"
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

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_DIR" ]; then
    echo "Installing packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
else
    echo "✅ packer.nvim already installed"
fi

echo "To finalize Neovim setup, open nvim and run :PackerSync"

echo "✅ Bootstrap complete!"

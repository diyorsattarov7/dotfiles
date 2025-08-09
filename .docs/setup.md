# dotfiles setup

## 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Install Required Packages

```bash
brew install gnupg git tmux neovim
```

## 3. Set Up GnuPG

Add GPG TTY export to `.zshrc`:

```bash
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
source ~/.zshrc
```

Generate a GPG key:

```bash
gpg --full-generate-key
```

List secret keys:

```bash
gpg --list-secret-keys --keyid-format=long
```

Configure Git to sign commits:

```bash
git config --global user.signingkey KEY_ID
git config --global commit.gpgsign true
```

## 4. Set Up SSH Key

Generate a new SSH key:

```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
```

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add your SSH private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Add the public key to GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

Test your GitHub SSH connection:

```bash
ssh -T git@github.com
```

## 5. Customize `.zshrc`

```zsh
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_} %(?.%F{magenta}>%f.%F{red}>%f) '

alias ls='ls -G'
alias ll='ls -la'
```

## 6. Install and Configure `tmux`

### Install TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Create `~/.tmux.conf`

```tmux
set -g default-terminal "screen-256color"

set -g prefix C-b
set -g base-index 1
setw -g pane-base-index 1

bind r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."

setw -g mode-keys vi
set -g mouse on

set-option -g allow-rename off
set-option -g default-shell /bin/zsh
set-option -g default-command /bin/zsh

bind | split-window -h
bind - split-window -v
bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "pbcopy"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'

run '~/.tmux/plugins/tpm/tpm'
```

### Start `tmux` and Install Plugins

```bash
tmux
```

Then press:

```
Ctrl + b then Shift + I
```

To install TPM plugins.

### Save/Restore Session with tmux-resurrect

- Save: `Ctrl + b` then `Ctrl + s`  
- Restore: `Ctrl + b` then `Ctrl + r`

## 7. Install and Configure Neovim

### Create Config Structure

```bash
mkdir -p ~/.config/nvim/lua/core
```

### `~/.config/nvim/lua/core/settings.lua`

```lua
-- core/settings.lua

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.g.mapleader = ' '

vim.opt.cindent = true
vim.opt.cinoptions = {
    "g0",
}

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
```

### `~/.config/nvim/lua/core/keymaps.lua`

```lua
-- core/keymaps.lua

local M = {}

function M.setup()
    require("core.keymaps.basic").setup()
end

return M
```

### `~/.config/nvim/lua/core/keymaps/basic.lua`

```lua
-- core/keymaps/basic.lua
local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })
    vim.keymap.set({"n", "v"}, "<leader>x", "\"+y", { desc = "Yank to Clipboard" })
    vim.keymap.set("n", "<leader>d", "x", { desc = "Delete" })
    vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
    end, { desc = "Show Diagnostic" })
    vim.keymap.set("n", "<leader>fc", function()
        vim.cmd("set filetype=cpp")
        print("Filetype set to C++")
    end, { desc = "Set Filetype to C++" })
    vim.keymap.set("n", "<leader>t", vim.cmd.terminal, { desc = "Open Terminal" })
    vim.keymap.set("t", "<C-q>", [[<C-\><C-n>:bd!<CR>]], { desc = "Force quit terminal" })
end

return M
```

### `~/.config/nvim/init.lua`

```lua
require('core.settings')
require('core.keymaps').setup()
```

## 8. Install and Configure Packer (Neovim Package Manager)

### Clone Packer Repository

```bash
git clone --depth 1 [https://github.com/wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Add Packer Configuration

### Install Plugins

1.  Open Neovim:

    ```bash
    nvim
    ```

2.  Run the `:source` command on your Packer configuration file (typically `packer.lua` if you created one separately, or your `init.lua` if you added the Packer configuration there):

    ```vim
    :so
    ```

3.  Run the `:PackerSync` command to install the plugins listed in your Packer configuration:

    ```vim
    :PackerSync
    ```

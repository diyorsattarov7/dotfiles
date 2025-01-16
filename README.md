# Dotfiles

A collection of configuration files to set up a development environment with **Zsh**, **tmux**, and **Neovim**.

## Features

### Zsh (`.zshrc`)
- Color support and Git branch in prompt.
- Aliases:
  - `ls`: Colorized output.
  - `ll`: Detailed listing.
- Custom prompt with user, host, directory, and Git branch info.

### tmux (`.tmux.conf`)
- Improved colors with `screen-256color`.
- Vi-mode navigation.
- Mouse support enabled.
- Plugins managed via [TPM](https://github.com/tmux-plugins/tpm):
  - `tmux-sensible`
  - `tmux-resurrect`

### Neovim (`.config/nvim`)
- Plugin management with [packer.nvim](https://github.com/wbthomason/packer.nvim).
- Pre-configured LSP support for `clangd`, `lua_ls`, and `rust-analyzer`.
- Integrated tools:
  - [Telescope](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding.
  - [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting.
  - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git integration.
  - [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) for Rust development.
- Essential settings:
  - Tabs and indentation (`expandtab`, `shiftwidth`, `tabstop`).
  - Relative line numbers and `termguicolors`.
- Keymaps:
  - `<leader>pv`: Open file explorer.
  - `<leader>pf`: Find files.
  - `<C-p>`: Search Git files.

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/diyorsattarov7/dotfiles.git
   ```
2. Symlink the configuration files:
   ```bash
   ln -s $(pwd)/dotfiles/.zshrc ~/.zshrc
   ln -s $(pwd)/dotfiles/.tmux.conf ~/.tmux.conf
   ln -s $(pwd)/dotfiles/.config/nvim ~/.config/nvim
   ```
3. Install tmux plugins:
   - Open tmux and press `Ctrl-b I` to install plugins via TPM.
4. Install Neovim plugins:
   ```bash
   nvim +PackerSync
   ```
5. Restart your terminal and enjoy!

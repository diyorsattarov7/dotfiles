# dotfiles
Configuration files for Zsh, tmux, and Neovim development environment.

## Configuration

### Zsh
- Custom prompt with Git integration
- Color support and essential aliases

### tmux
- 256-color and Vi-mode support
- TPM plugins: sensible, resurrect

### Neovim
- Plugin management via packer.nvim
- LSP support (clangd, lua_ls, rust-analyzer)
- Core plugins: telescope, treesitter, gitsigns, rust-tools

## Install
```bash
git clone https://github.com/diyorsattarov7/dotfiles.git .
source .zshrc
```
# Install plugins
```bash
tmux # Then press Ctrl-b I
nvim +PackerSync
```

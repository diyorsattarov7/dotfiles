-- plugins/vimtex.lua
local g = vim.g

g.vimtex_view_general_viewer = 'zathura'

g.vimtex_compiler_method = 'latexmk'
g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
    },
}

g.vimtex_toc_config = {
    mode = 1,
    fold_enable = 0,
    hide_line_numbers = 1,
    resize = 0,
    refresh_always = 1,
    show_help = 0,
    show_numbers = 1,
    split_pos = 'leftabove',
    split_width = 30,
    tocdepth = 3,
    indent_levels = 1,
}

g.vimtex_quickfix_mode = 2
g.vimtex_quickfix_open_on_warning = 0

g.vimtex_syntax_enabled = 1

-- plugins/rust-tools.lua

local rt = require('rust-tools')

rt.setup({
  server = {
    on_attach = function(client, bufnr)
    end,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = { command = "clippy", enable = true },
        diagnostics = { disabled = {"unresolved-proc-macro"}, enableExperimental = false },
        check = { command = "check", extraArgs = {"--target-dir", "/tmp/rust-analyzer-check"} },
        procMacro = { enable = true },
      }
    }
  },
  tools = {
    hover_actions = { auto_focus = true },
    inlay_hints = { auto = true, show_parameter_hints = true },
  },
})


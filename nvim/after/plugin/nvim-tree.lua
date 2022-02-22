require('nvim-tree').setup {
  diagnostics = {
    enable = false,
    icons = {
      error = Q.lsp.signs.Error,
      warn = Q.lsp.signs.Warn,
      info = Q.lsp.signs.Info,
      hint = Q.lsp.signs.Hint,
    },
  },
  view = {
    auto_resize = true,
  },
}

Q.m("<Leader>'", '<Cmd>NvimTreeToggle<CR>')

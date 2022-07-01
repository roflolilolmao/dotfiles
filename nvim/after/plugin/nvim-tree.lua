require('nvim-tree').setup {
  diagnostics = {
    enable = false,
    icons = {
      error = Q.lsp.signs.Error,
      warning = Q.lsp.signs.Warn,
      info = Q.lsp.signs.Info,
      hint = Q.lsp.signs.Hint,
    },
  },
}

Q.m("<Leader>'", '<Cmd>NvimTreeToggle<CR>')

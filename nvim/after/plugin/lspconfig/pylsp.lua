require'lspconfig'['pylsp'].setup{
  cmd = {'pylsp'},
  on_attach = Q.lsp_on_attach,
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = false,
        },
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  }
}

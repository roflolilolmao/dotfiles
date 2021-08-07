require'lspconfig'['pylsp'].setup{
  cmd = {'pylsp'},
  capabilities = Q.lsp_capabilities,
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

require'lspconfig'['pylsp'].setup{
  cmd = {'pylsp'},
  capabilities = Q.lsp_capabilities,
  on_attach = function (client, bufnr)
    client.resolved_capabilities.document_formatting = false
    return Q.lsp_on_attach(client, bufnr)
  end,
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = false,
        },
        jedi_completion = {
          include_params = true,
          fuzzy = true,
          eager = true,
        },
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  }
}

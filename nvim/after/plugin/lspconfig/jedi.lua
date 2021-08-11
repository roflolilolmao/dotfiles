require'lspconfig'['jedi_language_server'].setup{
  on_attach = Q.lsp_on_attach,
  capabilities = Q.lsp_capabilities,
}

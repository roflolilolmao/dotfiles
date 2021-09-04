local null_ls = require'null-ls'

null_ls.config({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.markdownlint,
  },
  diagnostics_format = '[#{c}] #{m}',
})

require'lspconfig'['null-ls'].setup{
  capabilities = Q.capabilities,
  on_attach = Q.lsp_on_attach,
}

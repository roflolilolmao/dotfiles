local null_ls = require'null-ls'

local sources = {
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.isort,
  null_ls.builtins.diagnostics.flake8,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.diagnostics.markdownlint,
}

null_ls.config({
  sources=sources,
  diagnostics_format = '[#{c}] #{m}',
})

require'lspconfig'['null-ls'].setup{
  on_attach = Q.lsp_on_attach,
}

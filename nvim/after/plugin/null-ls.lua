local null_ls = require 'null-ls'

null_ls.config {
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,

    null_ls.builtins.formatting.stylua,

    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.markdownlint,

    null_ls.builtins.formatting.stylelint,
    null_ls.builtins.diagnostics.stylelint,
  },
}

require('lspconfig')['null-ls'].setup(vim.deepcopy(Q.lsp))

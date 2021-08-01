local markdownlint = {
  lintCommand = "markdownlint -s $(INPUT)",
  lintStdin = true
}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

require'lspconfig'['efm'].setup {
  on_attach = Q.lsp_on_attach,
  init_options = {documentFormatting = true},
  filetypes = {'javascript', 'typescript', 'markdown'},
  settings = {
    rootMarkers = {'.git'},
    languages = {
      markdown = {markdownlint},
      javascript = {eslint},
      typescript = {eslint},
    }
  }
}

local markdownlint = {
  lintCommand = "markdownlint -s $(INPUT)",
  lintStdin = true
}

require'lspconfig'['efm'].setup {
  on_attach = Q.lsp_on_attach,
  init_options = {documentFormatting = true},
  filetypes = {'markdown'},
  settings = {
    rootMarkers = {'.git'},
    languages = {
      markdown = {markdownlint},
    }
  }
}

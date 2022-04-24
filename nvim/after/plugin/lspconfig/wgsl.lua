lspconfig = require('lspconfig')

require('lspconfig.configs').wgsl = {
  default_config = {
    cmd = { 'wgsl_analyzer' },
    filetypes = { 'wgsl' },
    root_dir = lspconfig.util.root_pattern('.git', 'wgsl'),
    settings = {},
  },
}

lspconfig.wgsl.setup(vim.deepcopy(Q.lsp))

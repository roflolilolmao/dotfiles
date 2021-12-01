vim.g.rust_recommended_style = 0
vim.g.rustfmt_autosave = 1

local lsp_config = vim.deepcopy(Q.lsp)

lsp_config.settings = {
  ['rust-analyzer'] = {
    assist = {
      importGranularity = 'module',
      importEnforceGranularity = true,
    },
    checkOnSave = {
      command = 'clippy',
    },
  },
}

vim.cmd 'hi InlayHints guifg=#880088'

require('rust-tools').setup {
  tools = {
    inlay_hints = {
      only_current_line = true,
      highlight = 'InlayHints',
    },
    hover_actions = {
      border = Q.border,
    },
  },
  server = lsp_config,
}

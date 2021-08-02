require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'python',
    'lua',
    'html',
    'javascript',
    'css',
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Leader>v",
      node_incremental = "<Leader>m",
      node_decremental = "<Leader>w",
      scope_incremental = "<Leader>z",
    },
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
  },
}

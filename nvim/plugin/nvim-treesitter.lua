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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>s'] = '@parameter.inner',
      },
      swap_previous = {
        ['<Leader>S'] = '@parameter.inner',
      },
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
  },
}

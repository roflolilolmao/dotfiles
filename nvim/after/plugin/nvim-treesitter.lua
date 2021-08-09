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
      init_selection = '<Leader>v',
      node_incremental = '<Leader>m',
      node_decremental = '<Leader>w',
      scope_incremental = '<Leader>z',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ai'] = '@call.outer',
        ['ii'] = '@call.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>sa'] = '@parameter.inner',
        ['<Leader>sf'] = '@function.outer',
        ['<Leader>sc'] = '@class.outer',
        ['<Leader>si'] = '@call.outer',
        ['<Leader>sb'] = '@block.outer',
      },
      swap_previous = {
        ['<Leader>Sa'] = '@parameter.inner',
        ['<Leader>Sf'] = '@function.outer',
        ['<Leader>Sc'] = '@class.outer',
        ['<Leader>Si'] = '@call.outer',
        ['<Leader>Sb'] = '@block.outer',
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

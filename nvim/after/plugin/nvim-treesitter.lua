require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'python',
    'lua',
    'html',
    'javascript',
    'css',
    'rust',
  },
  highlight = {
    enable = true,
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
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>sa'] = '@parameter.inner',
        ['<Leader>sf'] = '@function.outer',
        ['<Leader>sc'] = '@class.outer',
        ['<Leader>si'] = '@call.outer',
        ['<Leader>sl'] = '@loop.outer',
      },
      swap_previous = {
        ['<Leader>Sa'] = '@parameter.inner',
        ['<Leader>Sf'] = '@function.outer',
        ['<Leader>Sc'] = '@class.outer',
        ['<Leader>Si'] = '@call.outer',
        ['<Leader>Sl'] = '@loop.outer',
      },
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

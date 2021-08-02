-- Reloading the config makes lualine disappear without reloading it.
require'plenary.reload'.reload_module('lualine')

local lualine = require'lualine'

local oceanic_next = require'lualine.themes.oceanicnext'

lualine.setup{
  options = {
    theme = oceanic_next,
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'branch',
        right_padding = 0,
      },
      {
        'diff',
        color_modified = '#ffffff',
        color_added = '#00ff00',
        color_removed = '#ff0000',
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'filename',
        path = 0,
        separator = '',
      },
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = Q.lsp_signs,
      },
    },
    lualine_z = {
      {
        'encoding',
        separator = '',
        right_padding = 0,
      },
      {
        'fileformat',
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
}

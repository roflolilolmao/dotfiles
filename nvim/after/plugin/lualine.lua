-- Reloading the config makes lualine disappear without reloading it.
require'plenary.reload'.reload_module('lualine')

local lualine = require'lualine'

local oceanic_next = require'lualine.themes.oceanicnext'

oceanic_next['insert']['b']['bg'] = nil
oceanic_next['normal']['b']['bg'] = nil
oceanic_next['inactive']['b']['bg'] = nil
oceanic_next['visual']['b']['bg'] = nil
oceanic_next['replace']['b']['bg'] = nil

oceanic_next['insert']['c']['bg'] = nil
oceanic_next['normal']['c']['bg'] = nil
oceanic_next['inactive']['c']['bg'] = nil
oceanic_next['visual']['c']['bg'] = nil
oceanic_next['replace']['c']['bg'] = nil

lualine.setup{
  options = {
    theme = oceanic_next,
    padding = 1,
    section_separators = {'', ''},
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'branch',
      },
--      leaks file descriptors
--      {
--        'diff',
--        color_modified = '#ffffff',
--        color_added = '#00ff00',
--        color_removed = '#ff0000',
--      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = Q.lsp_signs,
      },
      {
        'filename',
        path = 0,
        separator = '',
      },
      {
        'filetype',
      },
    },
    lualine_z = {
      {
        'encoding',
        right_padding = 0,
        separator = '',
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

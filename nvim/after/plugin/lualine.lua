-- Reloading the config makes lualine disappear without reloading it.
require'plenary.reload'.reload_module('lualine')

local lualine = require'lualine'

local oceanic_next = require'lualine.themes.OceanicNext'

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
  extensions = {'quickfix'},
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'branch',
      },
      {
        'diff',
        color_modified = { fg = '#ffffff'},
        color_added = { fg = '#00ff00'},
        color_removed = { fg = '#ff0000'},
      },
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
        path = 1,
        shorting_target = 40,
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
    lualine_y = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
        separator = '',
      },
      {
        'filetype',
        right_padding = 10,
      },
    },
    lualine_z = {},
  },
}

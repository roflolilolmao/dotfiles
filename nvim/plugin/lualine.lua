-- Reloading the config makes lualine disappear without reloading it.
require'plenary.reload'.reload_module('lualine')
local lualine = require'lualine'

--[[
  Maybe separators will be easier to set up:
  https://github.com/hoob3rt/lualine.nvim/pull/255

  options = {
    component_separators = '',
  },
]]

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
  extensions = {
    'quickfix',
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      {
        'branch',
        separator = '',
        right_padding = 0,
      },
      {
        'diff',
        color_modified = '#ffffff',
        color_added = '#00ff00',
        color_removed = '#ff0000',
      },
    },
    lualine_c = {
      {
        'filename',
        path = 1,
        separator = '',
      },
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        symbols = Q.lsp_signs,
      },
    },
    lualine_x = {
      {
        'filetype',
      },
    },
    lualine_y = {
      {
        'encoding',
        separator = '',
        right_padding = 0,
      },
      {
        'fileformat',
        left_padding = 0,
        format = function(arg) return '[' .. arg .. ']' end,
      },
    },
  },
}

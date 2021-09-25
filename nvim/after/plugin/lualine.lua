local oceanic_next = require 'lualine.themes.OceanicNext'

oceanic_next.inactive.a.bg = nil

oceanic_next.insert.b.bg = nil
oceanic_next.normal.b.bg = nil
oceanic_next.inactive.b.bg = nil
oceanic_next.visual.b.bg = nil
oceanic_next.replace.b.bg = nil

oceanic_next.insert.c.bg = nil
oceanic_next.normal.c.bg = nil
oceanic_next.inactive.c.bg = nil
oceanic_next.visual.c.bg = nil
oceanic_next.replace.c.bg = nil

local empty = { { '" "', padding = 0 } }

require('lualine').setup {
  options = {
    disabled_filetypes = {'fixity'},
    theme = oceanic_next,
  },
  extensions = {
    'quickfix',
    {
      sections = {
        lualine_a = { 'mode' },
      },
      filetypes = { 'gitcommit' },
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
      },
    },
    lualine_b = empty,
    lualine_c = {
      {
        'branch',
        separator = '',
        padding = { left = 0, right = 0 },
      },
      {
        'diff',
        diff_color = {
          modified = { fg = '#ffffff' },
          added = { fg = '#00ff00' },
          removed = { fg = '#ff0000' },
        },
      },
    },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim' },
        symbols = {
          error = Q.lsp.signs.Error,
          warn = Q.lsp.signs.Warn,
          info = Q.lsp.signs.Info,
          hint = Q.lsp.signs.Hint,
        },
      },
      {
        'filename',
        path = 1,
        shorting_target = 40,
        separator = '',
      },
      {
        'filetype',
        padding = { left = 0, right = 0 },
      },
    },
    lualine_y = empty,
    lualine_z = {
      {
        'encoding',
        padding = { right = 0, left = 1 },
        separator = '',
      },
      {
        'fileformat',
      },
    },
  },
  inactive_sections = {
    lualine_a = empty,
    lualine_b = empty,
    lualine_c = {
      {
        'branch',
        padding = { left = 8, right = 1 },
      },
    },
    lualine_x = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
        separator = '',
      },
      {
        'filetype',
        separator = '',
        padding = { right = 0, left = 0 },
      },
    },
    lualine_y = empty,
    lualine_z = {
      {
        -- empty components are ignored, an empty string will force lualine to
        -- use the padding regardless of the presence of a file type or not
        '" "',
        padding = { right = 8, left = 1 },
      },
    },
  },
}

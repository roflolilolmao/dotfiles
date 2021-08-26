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

require'lualine'.setup{
  options = {
    theme = oceanic_next,
  },
  extensions = {
    'quickfix',
    {
      sections = {lualine_a = {'mode'}},
      filetypes = {'gitcommit'},
    },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        left_padding = 4,
      },
    },
    lualine_b = {},
    lualine_c = {
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
    lualine_x = {
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
    lualine_y = {},
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
    lualine_c = {
      {
        left_padding = 12,
        'branch',
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
      },
      {
        -- empty components are ignored, an empty string will force lualine to
        -- use the padding regardless of the presence of a file type or not
        '" "',
        right_padding = 7,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
}

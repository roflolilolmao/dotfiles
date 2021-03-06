require 'impatient'

vim.g['python3_host_prog'] = 'python'

local disabled_built_ins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'matchit',
  'matchparen',
  'netrw',
  'netrwFileHandlers',
  'netrwPlugin',
  'netrwSettings',
  'rrhelper',
  'spellfile_plugin',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

local disabled_providers = { 'python', 'ruby', 'perl' }

for _, provider in pairs(disabled_providers) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

vim.api.nvim_set_keymap(
  '',
  '<Space>',
  '<Nop>',
  { noremap = true, silent = true }
)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

Q = {
  border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },

  m = function(lhs, rhs, modes, options)
    options = options or { noremap = true }
    modes = modes or 'n'
    for _, mode in ipairs(vim.split(modes, '')) do
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
  end,
}

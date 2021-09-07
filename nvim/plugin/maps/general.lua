Q.m('<C-h>', '<C-w><C-h>')
Q.m('<C-j>', '<C-w><C-j>')
Q.m('<C-k>', '<C-w><C-k>')
Q.m('<C-l>', '<C-w><C-l>')

Q.m('<C-q>', '<C-w><C-q>')
Q.m('<C-,>', '<Cmd>bd<CR>')

Q.m('<C-Tab>', '<Cmd>bnext<CR>')
Q.m('<S-Tab>', '<Cmd>bprevious<CR>')
Q.m('<PageUp>', '<C-PageUp>')
Q.m('<PageDown>', '<C-PageDown>')

Q.m('ZZ', '<Esc>ZZ', 'i')

Q.m('<C-/>', '<Cmd>nohlsearch<Bar>diffupdate<Bar>syntax sync fromstart<CR>')
Q.m(
  '<CR>',
  '{-> v:hlsearch ? "\\<C-/>" : "\\<CR>"}()',
  'n',
  { expr = true, silent = true }
)

Q.m('<leader>y', '"+y')

Q.m('<Leader>r', 's', 'nv')

Q.m('<leader>o', 'm`o<Esc>``')
Q.m('<leader>O', 'm`O<Esc>``<C-e>')

Q.m('<C-CR>', '<C-o>o', 'i')
Q.m('<S-CR>', '<C-o>O', 'i')

Q.m('gx', [[<Cmd>silent! !$BROWSER <cWORD><CR>]])

Q.m('<F12>', [[<Cmd>so %<CR>]])

Q.m('<Leader>w', '<Cmd>set wrap!<CR>')

-- Command line maps to insert the current filename or complete path.
-- Taken from
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim
Q.m('<C-r><C-t>', [[<C-r>=expand('%:t')<CR>]], 'c')
Q.m('<C-r><C-p>', [[<C-r>=expand('%:h')<CR>/]], 'c')

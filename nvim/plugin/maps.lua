Q.m('n', '<C-h>', '<C-w><C-h>')
Q.m('n', '<C-j>', '<C-w><C-j>')
Q.m('n', '<C-k>', '<C-w><C-k>')
Q.m('n', '<C-l>', '<C-w><C-l>')

Q.m('n', '<C-q>', '<C-w><C-q>')
Q.m('n', '<C-,>', '<Cmd>bd<CR>')

Q.m('n', '<C-Tab>', '<Cmd>bnext<CR>')
Q.m('n', '<S-Tab>', '<Cmd>bprevious<CR>')
Q.m('n', '<PageUp>', '<C-PageUp>')
Q.m('n', '<PageDown>', '<C-PageDown>')

Q.m('i', 'ZZ', '<Esc>ZZ')

Q.m('n', '<CR>', '{-> v:hlsearch ? "\\<C-l>" : "\\<CR>"}()', {expr = true, silent = true, noremap = false})
Q.m('n', '<C-/>', '<C-l>', {noremap = false})

Q.m('n', '<leader>y', '"+y')

Q.m('n', '<leader>o', 'm`o<Esc>``')
Q.m('n', '<leader>O', 'm`O<Esc>``<C-e>')

Q.m('i', '<C-CR>', '<C-o>o')
Q.m('i', '<S-CR>', '<C-o>O')

-- Command line maps to insert the current filename or complete path.
-- Taken from
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim
Q.m('c', '<C-r><C-t>', [[<C-r>=expand('%:t')<CR>]])
Q.m('c', '<C-r><C-p>', [[<C-r>=expand('%:h')<CR>/]])

Q.m('n', 'gx', [[<Cmd>silent! !$BROWSER <cWORD><CR>]])

Q.m('n', '<F12>', [[<Cmd>so %<CR>]])

Q.m('n', '<F5>', '<Cmd>lua Q.save_all()<CR>')
Q.m('i', '<F5>', '<Esc><Cmd>lua Q.save_all()<CR>')

Q.m('n', '<Leader>n', [[<Cmd>lua Q.cn(0)<CR>]])
Q.m('n', '<Leader>N', [[<Cmd>lua Q.cn(-1)<CR>]])

for key, _ in pairs(Q.dirs) do
  Q.m(
    'n',
    '<Leader>a' .. key,
    [[<Cmd>lua Q.dirs.]] .. key .. [[()<CR>]]
  )
end

Q.m('n', '<Leader>aa', '<Cmd>pwd<CR>')

-- https://stackoverflow.com/questions/7292052/vim-select-inside-dots/7292271#7292271
Q.m('o', ',', [[<Cmd>exec 'normal v' . v:count1 . ','<CR>]])
Q.m('o', 'a,', [[<Cmd>exec 'normal v' . v:count1 . 'a,'<CR>]])
Q.m('o', 'i,', [[<Cmd>exec 'normal v' . v:count1 . 'i,'<CR>]])

Q.m('x', ',', 'f,oT,o')
Q.m('x', 'a,', 'f,oF,o')
Q.m('x', 'i,', 't,oT,o')

Q.m('o', '.', [[<Cmd>exec 'normal v' . v:count1 . '.'<CR>]])
Q.m('o', 'a.', [[<Cmd>exec 'normal v' . v:count1 . 'a.'<CR>]])
Q.m('o', 'i.', [[<Cmd>exec 'normal v' . v:count1 . 'i.'<CR>]])

Q.m('x', '.', 'f.oT.o')
Q.m('x', 'a.', 'f.oF.o')
Q.m('x', 'i.', 't.oT.o')

Q.m('o', '_', [[<Cmd>exec 'normal v' . v:count1 . '_'<CR>]])
Q.m('o', 'a_', [[<Cmd>exec 'normal v' . v:count1 . 'a_'<CR>]])
Q.m('o', 'i_', [[<Cmd>exec 'normal v' . v:count1 . 'i_'<CR>]])

Q.m('x', '_', 'f_oT_o')
Q.m('x', 'a_', 'f_oF_o')
Q.m('x', 'i_', 't_oT_o')

Q.m('n', 'R', [[Q_Replace()]], {expr = true})
Q.m('n', 'RR', [[Q_Replace() .. '_']], {expr = true})
Q.m('n', '<Leader>A', [[Q_Append()]], {expr = true})
Q.m('n', '<Leader>AA', [[Q_Append() .. '_']], {expr = true})
Q.m('n', '<Leader>I', [[Q_Insert()]], {expr = true})
Q.m('n', '<Leader>II', [[Q_Insert() .. '_']], {expr = true})

Q.m('n', '<Leader>c', [[Q_ToggleComment()]], {expr = true})
Q.m('n', '<Leader>cc', [[Q_ToggleComment() .. '_']], {expr = true})

Q.m('n', '<Leader>r', 's')
Q.m('v', '<Leader>r', 's')

Q.m('n', '<Leader>,', [[<Cmd>call fixity#dev()<CR>]])

Q.diff_mode = function()
  if vim.wo.diff then
    Q.m('n', 'n', ']czz')
    Q.m('n', 'N', '[czz')
    Q.m('n', 'o', 'do')
    Q.m('n', 'O', '<Cmd>.diffget<CR>')
    Q.m('n', 'p', 'dp')
    Q.m('n', 'P', '<Cmd>.diffput<CR>')
  end
end

Q.m('n', '<leader><leader>d', '<Cmd>lua Q.diff_mode()<CR>')
Q.m('n', '<Leader><Leader>w', '<Cmd>lua Q.set_wrap()<CR>')
Q.m('n', '<Leader><Leader>s', '<Cmd>lua Q.syntax_sync()<CR>')
Q.m('n', '<Leader>/', '<Cmd>lua Q.get_highlight()<CR>')

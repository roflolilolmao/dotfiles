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

Q.m('<C-/>', '<Cmd>nohlsearch<Bar>diffupdate<CR>')
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

-- Command line maps to insert the current filename or complete path.
-- Taken from
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim
Q.m('<C-r><C-t>', [[<C-r>=expand('%:t')<CR>]], 'c')
Q.m('<C-r><C-p>', [[<C-r>=expand('%:h')<CR>/]], 'c')

Q.m('gx', [[<Cmd>silent! !$BROWSER <cWORD><CR>]])

Q.m('<F12>', [[<Cmd>so %<CR>]])

Q.m('<F5>', '<Esc><Cmd>lua Q.save_all()<CR>', 'ni')

Q.m('<Leader>n', [[<Cmd>lua Q.cn(0)<CR>]])
Q.m('<Leader>N', [[<Cmd>lua Q.cn(-1)<CR>]])

for key, _ in pairs(Q.dirs) do
  Q.m('<Leader>a' .. key, [[<Cmd>lua Q.dirs.]] .. key .. [[()<CR>]])
end

Q.m('<Leader>aa', '<Cmd>pwd<CR>')

local function make_text_object(key)
  -- https://stackoverflow.com/questions/7292052/vim-select-inside-dots/7292271#7292271
  Q.m(key, [[<Cmd>exec 'normal v' . v:count1 . ']] .. key .. [['<CR>]], 'o')
  Q.m(
    'a' .. key,
    [[<Cmd>exec 'normal v' . v:count1 . 'a]] .. key .. [['<CR>]],
    'o'
  )
  Q.m(
    'i' .. key,
    [[<Cmd>exec 'normal v' . v:count1 . 'i]] .. key .. [['<CR>]],
    'o'
  )

  Q.m(key, 'f' .. key .. 'oT' .. key .. 'o', 'x')
  Q.m('a' .. key, 'f' .. key .. 'oF' .. key .. 'o', 'x')
  Q.m('i' .. key, 't' .. key .. 'oT' .. key .. 'o', 'x')
end

Q.opfuncs = {}

local function make_operator(prefix, key, func_name)
  local options = { noremap = true, expr = true }
  local opfunc = 'v:lua.Q.opfuncs.' .. func_name

  Q.opfuncs[func_name] = function(type)
    if not type then
      vim.o.opfunc = opfunc
      return 'g@'
    end
    Q[func_name](type)
  end

  Q.m(prefix .. key, opfunc .. '()', 'vn', options)
  Q.m(prefix .. key .. key, opfunc .. '().."_"', 'n', options)
end

make_text_object '.'
make_text_object ','
make_text_object '_'

make_operator('', 'R', 'replace')
make_operator('<Leader>', 'c', 'toggle_comment')
make_operator('<Leader>', 'A', 'append')
make_operator('<Leader>', 'I', 'insert')

Q.diff_mode = function()
  if vim.wo.diff then
    Q.m('n', ']czz')
    Q.m('N', '[czz')
    Q.m('o', 'do')
    Q.m('O', '<Cmd>.diffget<CR>')
    Q.m('p', 'dp')
    Q.m('P', '<Cmd>.diffput<CR>')
  end
end

Q.m('<Leader>,', [[<Cmd>call fixity#dev()<CR>]])
Q.m('<Leader>m', '<Cmd>messages<CR>')

Q.m('<leader><leader>d', '<Cmd>lua Q.diff_mode()<CR>')
Q.m('<Leader><Leader>w', '<Cmd>lua Q.set_wrap()<CR>')
Q.m('<Leader><Leader>s', '<Cmd>lua Q.syntax_sync()<CR>')
Q.m('<Leader>/', '<Cmd>lua Q.get_highlight()<CR>')

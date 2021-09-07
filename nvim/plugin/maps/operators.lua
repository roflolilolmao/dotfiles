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


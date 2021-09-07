Q.replace = function(type)
  local selection = {
    line = [['[V']\"zygv\"vp]],
    char = [[`[v`]\"zc]],
    block = [[`[\<C-v>`]\"zc]],
  }

  vim.cmd [[let @v=@"]]
  vim.cmd('exe "normal! ' .. selection[type] .. [[\<C-r>v\<Esc>"]])
  vim.cmd [[let @"=@v]]
end

Q.insert = function()
  local insert = vim.fn.input 'Insert: '

  local start_line = vim.fn.line "'["

  for index, line in ipairs(vim.fn.getline("'[", "']")) do
    local current_line = start_line + index - 1
    local indent, text = line:match '^(%s*)(.*)$'
    vim.fn.setline(current_line, indent .. insert .. text)
  end
end

Q.append = function()
  -- Idea: this could work charwise; for example: `<Leader>AiW`.

  local append = vim.fn.input 'Append:'

  local start_line = vim.fn.line "'["

  for index, line in ipairs(vim.fn.getline("'[", "']")) do
    local current_line = start_line + index - 1
    vim.fn.setline(current_line, line .. append)
  end
end

Q.toggle_comment = function()
  require('ts_context_commentstring.internal').update_commentstring()
  local comment_string = vim.o.commentstring:gsub(vim.pesc '%s', '')

  local start_line_number = vim.fn.line "'["
  local start_line = vim.fn.getline(start_line_number)
  local indent = start_line:match '^(%s*).*$'

  local change

  if start_line:match('^%s*' .. vim.pesc(comment_string)) ~= nil then
    change = function(line)
      local new_line = line:gsub(vim.pesc(comment_string), '', 1)
      return new_line
    end
  else
    change = function(line)
      local text = line:match('^' .. indent .. '(.*)$')
      if text == nil then
        text = line:match '^%s*(.*)$'
      end
      if text == '' then
        return ''
      end
      return indent .. vim.o.commentstring:format(text)
    end
  end

  for index, line in ipairs(vim.fn.getline("'[", "']")) do
    vim.fn.setline(start_line_number + index - 1, change(line))
  end
end

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

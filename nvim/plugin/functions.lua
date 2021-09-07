local a = vim.api
local c = vim.cmd
local f = vim.fn

function Q.dump(...)
  local args = ...
  if type(args) ~= table then
    args = {...}
  end
  print(unpack(vim.tbl_map(vim.inspect, args)))
  return ...
end

function Q.set_wrap()
  vim.wo.wrap = not vim.wo.wrap
end

function Q.syntax_sync()
  c 'syntax sync fromstart'
end

Q.cn = function(direction)
  local index = f.getqflist({ idx = 0 }).idx
  if index == 0 then
    return
  end

  local filtered = f.filter(f.getqflist(), function(i)
    return i ~= index - 1
  end)

  local title = f.getqflist({ title = 0 }).title
  f.setqflist({}, ' ', { title = title, items = filtered })

  if not next(filtered) then
    c 'cclose'
    return
  end

  c(index + direction .. 'cc')
end

Q.save_if_file_exists = function()
  local filename = a.nvim_buf_get_name(0)

  if filename ~= nil and filename ~= '' then
    c 'update'
  end
end

Q.save_all = function()
  local view = f.winsaveview()
  c 'mark Z'
  c 'bufdo lua Q.save_if_file_exists()'
  c 'silent! normal! `Z'
  f.winrestview(view)
end

Q.get_highlight = function()
  -- TODO: this doesn't seem to work with tree-sitter highlighting

  local id = f.synID(f.line '.', f.col '.', 1)
  local highlight = (
      f.synIDattr(id, 'name')
      .. ' -> '
      .. f.synIDattr(f.synIDtrans(id), 'name')
    )
  Q.dump(highlight)
  return highlight
end

Q.replace = function(type)
  local selection = {
    line = [['[V']\"zygv\"vp]],
    char = [[`[v`]\"zc]],
    block = [[`[\<C-v>`]\"zc]],
  }

  c [[let @v=@"]]
  c('exe "normal! ' .. selection[type] .. [[\<C-r>v\<Esc>"]])
  c [[let @"=@v]]
end

Q.insert = function()
  local insert = f.input 'Insert: '

  local start_line = f.line "'["

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1
    local indent, text = line:match '^(%s*)(.*)$'
    f.setline(current_line, indent .. insert .. text)
  end
end

Q.append = function()
  -- Idea: this could work charwise; for example: `<Leader>AiW`.

  local append = f.input 'Append:'

  local start_line = f.line "'["

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1
    f.setline(current_line, line .. append)
  end
end

Q.toggle_comment = function()
  require('ts_context_commentstring.internal').update_commentstring()
  local comment_string = vim.o.commentstring:gsub(vim.pesc '%s', '')

  local start_line_number = f.line "'["
  local start_line = f.getline(start_line_number)
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

  for index, line in ipairs(f.getline("'[", "']")) do
    f.setline(start_line_number + index - 1, change(line))
  end
end

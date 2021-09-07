function Q.dump(...)
  local args = ...
  if type(args) ~= table then
    args = {...}
  end
  print(unpack(vim.tbl_map(vim.inspect, args)))
  return ...
end

Q.cn = function(direction)
  local index = vim.fn.getqflist({ idx = 0 }).idx
  if index == 0 then
    return
  end

  local filtered = vim.fn.filter(vim.fn.getqflist(), function(i)
    return i ~= index - 1
  end)

  local title = vim.fn.getqflist({ title = 0 }).title
  vim.fn.setqflist({}, ' ', { title = title, items = filtered })

  if not next(filtered) then
    vim.cmd 'cclose'
    return
  end

  vim.cmd(index + direction .. 'cc')
end

Q.save_if_file_exists = function()
  local filename = vim.api.nvim_buf_get_name(0)

  if filename ~= nil and filename ~= '' then
    vim.cmd 'update'
  end
end

Q.save_all = function()
  local view = vim.fn.winsaveview()
  vim.cmd 'mark Z'
  vim.cmd 'bufdo lua Q.save_if_file_exists()'
  vim.cmd 'silent! normal! `Z'
  vim.fn.winrestview(view)
end

Q.get_highlight = function()
  -- TODO: this doesn't seem to work with tree-sitter highlighting

  local id = vim.fn.synID(vim.fn.line '.', vim.fn.col '.', 1)
  local highlight = (
      vim.fn.synIDattr(id, 'name')
      .. ' -> '
      .. vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name')
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

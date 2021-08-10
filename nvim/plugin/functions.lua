local a = vim.api
local c = vim.cmd
local f = vim.fn

local config = f.stdpath('config') .. '/'

local home = '~/'
if f.has('win32') ~= 0 then
  home = '\\\\wsl$/q/home/q/'  -- TODO: use wslpath+wslenv
end

local set_dir = function(directory)
  a.nvim_set_current_dir(directory)
  c('pwd')
end

function Q.dump(...)
  print(unpack(vim.tbl_map(vim.inspect, {...})))
  return ...
end

function Q.set_wrap()
  vim.wo.wrap = not vim.wo.wrap
end

Q.cn = function(direction)
  local index = f.getqflist{idx=0}.idx
  if index == 0 then
    return
  end

  local filtered = f.filter(
    f.getqflist(),
    function(i, v)
      return i ~= index - 1
    end
  )

  local title = f.getqflist{title=0}.title
  f.setqflist({}, ' ', {title=title, items=filtered})

  if not next(filtered) then
    c('cclose')
    return
  end

  c(index + direction .. 'cc')
end

Q.save_if_file_exists = function()
  filename = a.nvim_buf_get_name(0)

  if filename ~= nil and filename ~= ''  then
    c('update')
  end
end

Q.save_all = function()
  view = f.winsaveview()
  c('mark Z')
  c('bufdo lua Q.save_if_file_exists()')
  c('silent! normal! `Z')
  f.winrestview(view)
end

Q.get_highlight = function()
  -- TODO: this doesn't seem to work with tree-sitter highlighting

  local id = f.synID(f.line('.'), f.col('.'), 1)
  local highlight = (
    f.synIDattr(id, 'name')
    .. ' -> '
    .. f.synIDattr(f.synIDtrans(id), 'name')
  )
  Q.dump(highlight)
  return highlight
end

Q.dirs = {
  c = function()
    set_dir(config .. '..')
  end;

  n = function()
    set_dir(config)
  end;

  d = function()
    set_dir(home .. 'dev')
  end;

  t = function()
    set_dir(home .. 'dev/tree-sitter-markdown')
  end;

  v = function()
    set_dir(home .. 'dev/Valo')
  end;

  o = function()
    set_dir(config .. 'pack/plugins/start/oceanic-next-nvim')
  end;
}

Q.replace = function(arg)
  local selection = {
    line = [['[V']\"zygv\"vp]],
    char = [[`[v`]\"zc]],
    block = [[`[\<C-v>`]\"zc]],
  }

  c([[let @v=@"]])
  c('exe "normal! ' .. selection[arg] .. [[\<C-r>v\<Esc>"]])
  c([[let @"=@v]])
end

Q.I = function (arg)
  local insert = f.input('Insert: ')

  local start_line = f.line("'[")

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1
    local indent, text = line:match('^(%s*)(.*)$')
    f.setline(current_line, indent .. insert .. text)
  end
end

Q.A = function (arg)
  -- Idea: this could work charwise; for example: `<Leader>AiW`.

  local append = f.input('Append:')

  local start_line = f.line("'[")

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1
    f.setline(current_line, line .. append)
  end
end

Q.toggle_comment = function()
  require('ts_context_commentstring.internal').update_commentstring()
  local comment_string = vim.o.commentstring:gsub(vim.pesc('%s'), '')

  local start_line = f.line("'[")

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1

    local new_line, found = line:gsub(vim.pesc(comment_string), '', 1)

    if found == 0 then
      local indent, text = line:match('^(%s*)(.*)$')
      new_line = indent .. vim.o.commentstring:format(text)
    end

    f.setline(current_line, new_line)
  end
end

a.nvim_exec(
  [[
  function! Q_Replace(type = '')
    if a:type == ''
      set opfunc=Q_Replace
      return 'g@'
    endif

    exe "lua Q.replace('" .. a:type .. "')"
  endfunction

  function! Q_ToggleComment(type = '')
    if a:type == ''
      set opfunc=Q_ToggleComment
      return 'g@'
    endif

    exe "lua Q.toggle_comment()"
  endfunction

  function! Q_Insert(type = '')
    if a:type == ''
      set opfunc=Q_Insert
      return 'g@'
    endif

    exe "lua Q.I('" .. a:type .. "')"
  endfunction

  function! Q_Append(type = '')
    if a:type == ''
      set opfunc=Q_Append
      return 'g@'
    endif

    exe "lua Q.A('" .. a:type .. "')"
  endfunction
  ]],
  false
)

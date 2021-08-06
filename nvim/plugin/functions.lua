local a = vim.api
local c = vim.cmd
local f = vim.fn

local config = f.stdpath('config') .. '/'

local wsl = '~/'
if f.has('win32') ~= 0 then
  wsl = '\\\\wsl$/q/home/q/'  -- TODO: use wslpath+wslenv
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

Q.to_html = function()
  local filename = '"/tmp/' .. f.expand('%:t') .. '.html"'

  c('runtime! syntax/to_html.vim')
  c('write! ' .. filename)
  c('!$BROWSER ' .. filename)
  c('bdelete')
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
  local id = f.synID(f.line('.'), f.col('.'), 1)
  return (
    f.synIDattr(id, 'name')
    .. ' -> '
    .. f.synIDattr(f.synIDtrans(id), 'name')
  )
end

Q.dirs = {
  open_config = {
    key = 'c',
    func = function()
      set_dir(config .. '..')
    end,
  },

  open_nvim_config = {
    key = 'n',
    func = function()
      set_dir(config)
    end,
  },

  open_dev = {
    key = 'd',
    func = function()
      set_dir(wsl .. 'dev')
    end,
  },

  open_valo = {
    key = 'v',
    func = function()
      set_dir(wsl .. 'dev/Valo')
    end,
  },

  open_oceanic = {
    key = 'o',
    func = function()
      set_dir(config .. 'pack/plugins/start/oceanic-next-nvim')
    end,
  },
}

Q.replace = function(arg)
  local selection = {
    line = "'[V']\\\"zygv\\\"vp",
    char = '`[v`]\\"zc',
    block = '`[\\<C-v>`]\\"zc',
  }

  c([[let @v=@"]])
  c('exe "normal! ' .. selection[arg] .. [[\<C-r>v\<Esc>"]])
  c([[let @"=@z]])
end

Q.toggle_comment = function()
  require('ts_context_commentstring.internal').update_commentstring()
  local comment_string = vim.o.commentstring:gsub(vim.pesc('%s'), '')

  local start_line = f.line("'[")

  for index, line in ipairs(f.getline("'[", "']")) do
    local current_line = start_line + index - 1

    local new_line, found = line:gsub(vim.pesc(comment_string), '', 1)

    -- TODO: comment from ^, not 0
    if found == 0 then
      new_line = vim.o.commentstring:format(line)
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
  ]],
  false
)

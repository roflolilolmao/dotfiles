local home = '~/'
if vim.fn.has 'win32' ~= 0 then
  home = '\\\\wsl$/q/home/q/' -- TODO: use wslpath+wslenv
end

local config = vim.fn.stdpath 'config' .. '/'

local dirs = {
  c = config .. '..',
  n = config,
  d = home .. 'dev',
  t = home .. 'dev/tree-sitter-markdown',
  v = home .. 'dev/Valo',
  o = config .. 'pack/plugins/start/oceanic-next.nvim',
  g = config .. 'pack/plugins/start/fixity.nvim',
}

Q.change_directory = function(directory)
  vim.api.nvim_set_current_dir(directory)
  vim.cmd 'pwd'
  return ''
end

for key, dir in pairs(dirs) do
  Q.m(
    '<Leader>a' .. key,
    [[<Cmd>lua Q.change_directory("]] .. dir .. [[")<CR>]]
  )
end

Q.m('<Leader>aa', '<Cmd>pwd<CR>')

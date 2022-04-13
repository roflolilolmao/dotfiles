local dap = require('dap')
local dapui = require('dapui')

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/sbin/lldb-vscode',
  name = 'lldb',
}

dap.configurations.rust = {{
  -- name = 'launch',
  -- type = 'lldb',
  -- request = 'launch',
  -- program = function()
  --   return vim.fn.input('path to executable: ', vim.fn.getcwd() .. '/', 'file')
  -- end,
  -- cwd = '${workspaseFolder}',
  -- stopOnEntry = false,
  -- args = {},
  -- runInTerminal = false,
  name = "attach",
  type = 'rust',
  request = 'attach',
  pid = require('dap.utils').pick_process,
  args = {},
}}

dapui.setup {}

-- Q.m('<Leader>.', [[<Cmd>lua require'dapui'.toggle()<CR>]])
Q.m('<F4>.', [[<Cmd>lua require'dapui'.toggle()<CR>]])
Q.m('<F6>', [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]])
Q.m('<F7>', [[<Cmd>lua require'dap'.continue()<CR>]])
Q.m('<F8>', [[<Cmd>lua require'dap'.step_over()<CR>]])
Q.m('<F9>', [[<Cmd>lua require'dap'.step_into()<CR>]])
Q.m('<F10>', [[<Cmd>lua require'dap'.step_out()<CR>]])

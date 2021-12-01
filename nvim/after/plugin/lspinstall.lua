-- Configure lua language server for neovim development
-- local lua_settings = {
--   Lua = {
--     runtime = {
--       -- LuaJIT in the case of Neovim
--       version = 'LuaJIT',
--       path = vim.split(package.path, ';'),
--     },
--     diagnostics = {
--       -- Get the language server to recognize the `vim` global
--       globals = { 'vim' },
--     },
--     workspace = {
--       -- Make the server aware of Neovim runtime files
--       library = {
--         [vim.fn.expand '$VIMRUNTIME/lua'] = true,
--         [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
--       },
--     },
--   },
-- }

-- local lspinstall = require 'lspinstall'

-- -- lsp-install
-- local function setup_servers()
--   lspinstall.setup()

--   -- get all installed servers
--   local servers = lspinstall.installed_servers()

--   for _, server in pairs(servers) do
--     local config = vim.deepcopy(Q.lsp)

--     -- language specific config
--     if server == 'lua' then
--       config.settings = lua_settings
--     end

--     require('lspconfig')[server].setup(config)
--   end
-- end

-- setup_servers()

-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
-- lspinstall.post_install_hook = function()
--   setup_servers() -- reload installed servers
--   vim.cmd 'bufdo e'
-- end

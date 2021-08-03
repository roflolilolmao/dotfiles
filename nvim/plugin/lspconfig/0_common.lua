vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

Q.lsp_on_attach = function()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = {noremap=true, silent=true}

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  -- `vim.vim.lsp.buf.range_formatting` might be useful one day.
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

--  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<Leader>fs', '<Cmd> lua vim.lsp.buf.document_symbol()<CR>', opts)

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', '<Leader>dwa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>dwr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>dwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<Leader>ws', '<Cmd> lua vim.lsp.buf.workspace_symbol()<CR>', opts)

  buf_set_keymap('n', '<F2>', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>df', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '<Leader>de', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  buf_set_keymap('n', '<Leader>dn', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>dp', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization
local icons = {
  Class = ' ',
  Color = ' ',
  Constant = ' ',
  Constructor = ' ',
  Enum = '了 ',
  EnumMember = ' ',
  Field = ' ',
  File = ' ',
  Folder = ' ',
  Function = ' ',
  Interface = 'ﰮ ',
  Keyword = ' ',
  Method = 'ƒ ',
  Module = ' ',
  Property = ' ',
  Snippet = '﬌ ',
  Struct = ' ',
  Text = ' ',
  Unit = ' ',
  Value = ' ',
  Variable = ' ',
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons[kind] or kind
end

local lsp_symbols = Q.lsp_signs
local signs = {
  Error = lsp_symbols.error,
  Warning = lsp_symbols.warn,
  Hint = lsp_symbols.hint,
  Information = lsp_symbols.info,
}

for type, icon in pairs(signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

-- Show diagnostics source
vim.lsp.handlers['textDocument/publishDiagnostics'] =
  function(_, _, params, client_id, _)
    local config = {
      underline = false,
      virtual_text = false,
--      function ()
--        if vim.fn.mode() ~= 'n' then
--          return false
--        end
--        return {
--          prefix = '■ ',
--          spacing = 4,
--        }
--      end,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
    }

    local uri = params.uri
    local bufnr = vim.uri_to_bufnr(uri)

    if not bufnr then
      return
    end

    local diagnostics = params.diagnostics

    for i, v in ipairs(diagnostics) do
      diagnostics[i].message = string.format('%s: %s', v.source, v.message)
    end

    vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
      return
    end

    vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
  end

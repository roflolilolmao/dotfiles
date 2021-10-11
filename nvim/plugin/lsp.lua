local float_opts = {border = Q.border, focusable = false}

Q.lsp = {
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),

  flags = {
    debounce_text_changes = 500,
  },

  signs = {
    Error = '💯',
    Warn = '🚭',
    Info = '🚮',
    Hint = '⁉',
  },

  show_line_diagnostics = function()
    vim.diagnostic.show_line_diagnostics(float_opts)
  end,

  on_attach = function(_, bufnr)
    local function buf_map(map, func, args, mode)
      if args then
        args = vim.inspect(args, { newline = '', indent = '' })
      end

      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode or 'n',
        map,
        string.format([[<Cmd>lua %s(%s)<CR>]], func, args or ''),
        { noremap = true, silent = true }
      )
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Those might be useful one day but are handled by telescope right now
    -- vim.lsp.buf.range_formatting
    -- vim.lsp.buf.declaration
    -- vim.lsp.buf.implementation
    -- vim.lsp.buf.type_definition
    -- vim.lsp.buf.definition
    -- vim.lsp.buf.references
    -- vim.lsp.buf.document_symbol
    -- vim.lsp.buf.workspace_symbol
    -- vim.lsp.buf.code_action

    buf_map('<C-k>', 'vim.lsp.buf.signature_help', nil, 'i')
    buf_map('K', 'vim.lsp.buf.signature_help')
    buf_map('X', 'vim.lsp.buf.hover')

    buf_map('<Leader>dwa', 'vim.lsp.buf.add_workspace_folder')
    buf_map('<Leader>dwr', 'vim.lsp.buf.remove_workspace_folder')
    --buf_map('<Leader>dwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    buf_map('<Leader>df', 'vim.lsp.buf.formatting')
    buf_map('<F2>', 'vim.lsp.buf.rename')

    buf_map('<Leader>de', 'Q.lsp.show_line_diagnostics', float_opts)
    buf_map('<Leader>dn', 'vim.lsp.diagnostic.goto_next', {popup_opts = float_opts})
    buf_map('<Leader>dp', 'vim.lsp.diagnostic.goto_prev', {popup_opts = float_opts})
    buf_map('<Leader>dq', 'vim.lsp.diagnostic.set_loclist')
  end,
}

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
  Function = ' ',
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

for type, icon in pairs(Q.lsp.signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, numhl = '' })
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  float_opts
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  float_opts
)

-- Show diagnostics source
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    severity_sort = true,
    underline = true,
  }
)

Q.lsp = {
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),

  flags = {
    debounce_text_changes = 500,
  },

  on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true }

    local function buf_map(map, func, mode, args)
      if args then
        args = vim.inspect(args or {}, { newline = '', indent = '' })
      end

      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode or 'n',
        map,
        string.format([[<Cmd>lua vim.lsp.%s(%s)<CR>]], func, args or ''),
        opts
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

    buf_map('<C-k>', 'buf.signature_help', 'i')
    buf_map('K', 'buf.signature_help')
    buf_map('X', 'buf.hover')

    buf_map('<Leader>dwa', 'buf.add_workspace_folder')
    buf_map('<Leader>dwr', 'buf.remove_workspace_folder')
    --buf_map('<Leader>dwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

    buf_map('<Leader>df', 'buf.formatting')
    buf_map(
      '<Leader>de',
      'diagnostic.show_line_diagnostics',
      'n',
      { border = Q.border }
    )
    buf_map('<Leader>dn', 'diagnostic.goto_next')
    buf_map('<Leader>dp', 'diagnostic.goto_prev')

    buf_map('<F2>', 'buf.rename')
    buf_map('<Leader>q', 'diagnostic.set_loclist')
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

Q.lsp_signs = {
  Error = '💯',
  Warning = '🚭',
  Hint = '⁉',
  Information = '🚮',
}

for type, icon in pairs(Q.lsp_signs) do
  local hl = 'LspDiagnosticsSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = Q.border }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = Q.border }
)

-- Show diagnostics source
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = '',
      spacing = 8,
    },
    severity_sort = true,
    underline = false,
  }
)

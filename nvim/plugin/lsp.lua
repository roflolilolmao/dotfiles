Q.lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
Q.lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
Q.lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

Q.lsp_on_attach = function()
  local opts = {noremap=true, silent=true}

  local function buf_map(map, func)
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      map,
      [[<Cmd>lua vim.lsp.]] .. func .. [[()<CR>]],
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

  vim.api.nvim_buf_set_keymap(
    bufnr,
    'i',
    '<C-k>',
    '<Cmd>lua vim.lsp.buf.signature_help()<CR>',
    opts
  )

  buf_map('K', 'buf.hover')

  buf_map('<Leader>dwa', 'buf.add_workspace_folder')
  buf_map('<Leader>dwr', 'buf.remove_workspace_folder')
  --buf_map('<Leader>dwl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')

  buf_map('<Leader>df', 'buf.formatting')
  buf_map('<Leader>de', 'diagnostic.show_line_diagnostics')
  buf_map('<Leader>dn', 'diagnostic.goto_next')
  buf_map('<Leader>dp', 'diagnostic.goto_prev')

  buf_map('<F2>', 'buf.rename')
  buf_map('<Leader>q', 'diagnostic.set_loclist')
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

local function map_function(name, key, arg)
  if arg == nil then
    arg = ''
  end

  Q.m(
    '<Leader>' .. key,
    [[<Cmd>lua require'telescope.builtin'.]] .. name .. '(' .. arg .. ')<CR>'
  )
end

map_function('file_browser', 'tf')
map_function('find_files', 'ts')
map_function('grep_string', 'tG')
map_function('live_grep', 'tg')
map_function('buffers', 'tx')
map_function('help_tags', 'th')
map_function('current_buffer_fuzzy_find', 'tt')
map_function('oldfiles', 'to', '{cwd_only = true}')
map_function('oldfiles', 'tO')
map_function('registers', 'tr')
map_function('loclist', 'tl')
map_function('quickfix', 'tq')
map_function('command_history', ';')
map_function('commands', ':')
map_function('builtin', 'tz')
map_function('keymaps', 'tm')
map_function('highlights', 'ti')

map_function('git_stash', 'gx')
map_function('git_files', 'gf')
map_function('git_status', 'gs')
map_function('git_commits', 'gC')
map_function('git_branches', 'gb')
map_function('git_bcommits', 'gc')

map_function('lsp_references', 'dr')
map_function('lsp_definitions', 'dd')
map_function('lsp_code_actions', 'da')
map_function('lsp_range_code_actions', 'dA')

map_function('lsp_document_symbols', 'ds')
map_function('lsp_document_diagnostics', 'do')

map_function('lsp_workspace_symbols', 'dws')
map_function('lsp_dynamic_workspace_symbols', 'dwS')
map_function('lsp_workspace_diagnostics', 'dwo')

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<C-CR>'] = actions.smart_send_to_qflist + actions.open_qflist,
      },
      i = {
        ['<C-CR>'] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    layout_config = {
      flex = {
        flip_columns = 140,
      },
    },
    layout_strategy = 'flex',
  },
  pickers = {
    commands = require('telescope.themes').get_dropdown {},
    command_history = require('telescope.themes').get_dropdown {},
    current_buffer_fuzzy_find = require('telescope.themes').get_dropdown {},
    loclist = require('telescope.themes').get_dropdown {},
    quickfix = require('telescope.themes').get_dropdown {},
    builtin = require('telescope.themes').get_dropdown {
      previewer = false,
    },
    lsp_code_actions = require('telescope.themes').get_cursor {},
    lsp_range_code_actions = require('telescope.themes').get_cursor {},
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ['<C-x>'] = 'delete_buffer',
        },
        n = {
          ['x'] = 'delete_buffer',
        },
      },
    },
  },
}

require('telescope').load_extension 'fzf'

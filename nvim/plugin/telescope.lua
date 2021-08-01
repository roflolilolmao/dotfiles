local function map_function(name, key, arg)
  if arg == nil then
    arg = ''
  end

  Q.m(
    'n',
    '<Leader>t' .. key,
    [[<Cmd>lua require'telescope.builtin'.]] .. name .. '(' .. arg .. ')<CR>'
  )
end

map_function('file_browser', 'f')
map_function('find_files', 's')
map_function('grep_string', 'G')
map_function('live_grep', 'g')
map_function('buffers', 'x')
map_function('help_tags', 'h')
map_function('current_buffer_fuzzy_find', 't')
map_function('oldfiles', 'o', '{cwd_only = true}')
map_function('oldfiles', 'O')
map_function('registers', 'r')
map_function('loclist', 'l')
map_function('quickfix', 'q')
map_function('command_history', ';')
map_function('commands', ':')
map_function('builtin', 'z')
map_function('keymaps', 'm')
map_function('highlights', 'i')

map_function('git_stash', 'gx')
map_function('git_files', 'gf')
map_function('git_status', 'gs')
map_function('git_commits', 'gc')
map_function('git_branches', 'gb')
map_function('git_bcommits', 'gg')

local actions = require "telescope.actions"

require'telescope'.setup{
  defaults = {
    mappings = {
      n = {
        ['<Leader>n'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      i = {
        ['<C-Space>'] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
  pickers = {
    commands = require'telescope.themes'.get_dropdown {},
    command_history = require'telescope.themes'.get_dropdown {},
    current_buffer_fuzzy_find = require'telescope.themes'.get_dropdown {},
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
  }
}

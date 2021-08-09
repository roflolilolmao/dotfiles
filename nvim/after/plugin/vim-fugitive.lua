local function map_function(key, command)
  if arg == nil then
    arg = ''
  end

  Q.m(
    'n',
    '<Leader>g' .. key,
    '<Cmd>' .. command .. '<CR>'
  )
end

map_function('g', 'vertical topleft +0G')
map_function('l', 'vertical botright G log --graph --all --oneline --decorate')
map_function('s', 'G show --oneline --compact-summary')

Q.m(
  'n',
  '<Leader>gf',
  ':G show <C-r><C-g><CR>' -- <Cmd> escapes the <C- > mappings.
)

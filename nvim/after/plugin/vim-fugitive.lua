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
map_function('l', 'vertical botright G log --graph --oneline --decorate --branches --remotes')
map_function('S', 'G show --oneline --compact-summary')

Q.m(
  'n',
  '<Leader>gf',
  '<Cmd>G blame<CR>'
)

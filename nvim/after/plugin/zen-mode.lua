require('zen-mode').setup {
  window = {
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 120, -- width of the Zen window
    height = 0.95, -- height of the Zen window
    options = {
      signcolumn = 'yes', -- disable signcolumn
      number = false, -- disable number column
      relativenumber = false, -- disable relative numbers
    },
  },
}

Q.m('<F11>', [[<Cmd>ZenMode<CR>]])

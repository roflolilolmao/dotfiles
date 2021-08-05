vim.opt.ff = 'unix'
vim.opt.undofile = true
vim.opt.history = 200
vim.opt.hidden = true
vim.opt.updatetime = 200
vim.opt.autowrite = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.joinspaces = false
vim.opt.shortmess:append 'c'
vim.opt.backspace = {'indent', 'eol', 'start'}

vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = ' ↳ '

vim.opt.textwidth = 79
vim.opt.formatoptions = vim.opt.formatoptions
  - 't'
  + 'r'
  + 'n'
  + '1'
  + 'p'

vim.opt.spelllang = 'en'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'number'

vim.opt.wrapmargin = 0
vim.opt.wrap = false

vim.opt.showmode = false

vim.opt.equalalways = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.pumblend = 20

vim.opt.scrolloff = 5

vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true

vim.g.netrw_banner = 0

-- Required by compe
vim.opt.completeopt = {'menuone', 'noselect'}

vim.opt.wildmenu = true
vim.opt.wildignorecase = true
vim.opt.wildmode = 'full'
vim.opt.wildoptions = ''

vim.opt.wildignore:append {
  '*.o',
  '*.obj',
  '*.bin',
  '*.dll',
  '*/node_modules/*',
  '*/__pycache__/*',
  '*/build/**',
  '*.pyc',
  '*~',
}

vim.opt.belloff = 'all'
vim.opt.lazyredraw = true

vim.cmd 'colorscheme OceanicNext'

vim.opt.fillchars = { vert = ' ', eob = ' ' }

vim.cmd 'highlight VertSplit gui=NONE guifg=NONE guibg=NONE'
vim.cmd 'highlight TODO gui=bold,italic'

vim.cmd 'highlight StatusLine guibg=NONE'
vim.cmd 'highlight Normal guibg=NONE'
vim.cmd 'highlight LineNr guibg=NONE'
vim.cmd 'highlight SignColumn guibg=NONE'
vim.cmd 'highlight EndOfBuffer guibg=NONE'

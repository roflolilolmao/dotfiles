vim.opt.ff = 'unix'
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.shada = {'!', "'1000", '<50', 's10', 'h'}
vim.opt.hidden = true
vim.opt.updatetime = 200
vim.opt.autowrite = true
vim.opt.modeline = false

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
vim.opt.showcmd = false
vim.opt.ruler = false

vim.opt.equalalways = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.switchbuf = 'uselast'

vim.opt.pumblend = 20

vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 2
vim.opt.listchars = { -- '‹ ›⊳⋙⨌⨞⨠⩥⩤⨵⨴⪢⫸⫷⇶◁▷',
  tab = '⇤ ⇥',
  trail = '·',
  precedes = '◁',
  extends = '▷',
  nbsp = '▢',
  conceal = '◌',
}

vim.opt.inccommand = 'nosplit'
vim.opt.incsearch = true

vim.opt.wildmode = 'longest,full'
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

vim.opt.list = true
vim.opt.fillchars = { vert = ' ', eob = ' ' }

vim.cmd 'highlight VertSplit gui=NONE guifg=NONE guibg=NONE'
vim.cmd 'highlight TODO gui=bold,italic'

vim.cmd 'highlight StatusLine guibg=NONE'
vim.cmd 'highlight TabLineFill gui=NONE guibg=NONE'
vim.cmd 'highlight Normal guibg=NONE'
vim.cmd 'highlight LineNr guibg=NONE'
vim.cmd 'highlight SignColumn guibg=NONE'
vim.cmd 'highlight EndOfBuffer guibg=NONE'
vim.cmd 'highlight NonText guifg=#C594C5'

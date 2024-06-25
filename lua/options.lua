-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable ShaDa
vim.opt.shadafile = 'NONE'

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Scroll offset
vim.opt.scrolloff = 10

-- Mouse mode
vim.opt.mouse = 'a'

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive search by default
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn always visible
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitution
vim.opt.inccommand = 'split'

-- Termguicolors
vim.opt.termguicolors = true

-- Highlight search
vim.opt.hlsearch = true

-- Inlay hints
vim.g.inlay_hints_visible = true

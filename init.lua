-- Language
vim.cmd 'language en_US.UTF-8'

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.lsp.set_log_level 'off'

vim.opt.laststatus = 3 -- views can only be collapsed with the global statusline

require 'options'

if vim.g.neovide then
  require 'neovide'
end

require 'keymaps'

require 'autocmds'

require 'lazy-bootstrap'

-- Modeline
-- vim: ts=2 sts=2 sw=2 et

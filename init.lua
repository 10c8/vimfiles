-- Language
vim.cmd 'language en_US'

-- [[ Options ]]
-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- Inlay hints
vim.g.inlay_hints_visible = true

-- [[ Neovide ]]
if vim.g.neovide then
  vim.o.guifont = 'FiraCode Nerd Font Mono:h9'

  vim.g.neovide_cursor_animation_length = 0.03
  vim.g.neovide_cursor_trail_size = 0.5

  -- Keymaps
  vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to clipboard' })

  vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('!', '<C-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('i', '<C-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })
end

-- [[ Keymaps ]]
-- Highlight on search, clear on escape
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Motions
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Move half page up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Move half page down' })

-- Diagnostic navigation
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Buffers
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-n>', '<cmd>enew<CR>', { desc = 'Create a file in a new buffer' })
vim.keymap.set('n', '<C-t>', function()
  vim.cmd 'enew'

  require('telescope.builtin').find_files {
    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local entry = require('telescope.actions.state').get_selected_entry()
        require('telescope.actions').close(prompt_bufnr)

        vim.cmd('edit ' .. entry.path)
      end)

      return true
    end,
  }
end, { desc = 'Edit a file in a new buffer' })
vim.keymap.set('n', '<C-w>', '<cmd>bd<CR>', { desc = 'Close the current buffer' })
vim.keymap.set('n', '<C-S-w>', '<cmd>bd!<CR>', { desc = 'Close the current buffer (force)' })
vim.keymap.set('n', '<TAB>', '<cmd>bn<CR>', { desc = 'Switch to the next buffer' })
vim.keymap.set('n', '<S-TAB>', '<cmd>bp<CR>', { desc = 'Switch to the previous buffer' })

-- Splits
vim.keymap.set('n', '<leader>vh', '<cmd>split<CR>', { desc = 'Split the window [h]orizontally' })
vim.keymap.set('n', '<leader>vv', '<cmd>vsplit<CR>', { desc = 'Split the window [v]ertically' })

-- [[ Autocommands ]]
-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('yank-highlight', { clear = true }),
  callback = vim.highlight.on_yank,
})

-- Close neovide channel on exit
-- https://github.com/neovide/neovide/pull/2130
-- vim.api.nvim_create_autocmd('VimLeave', {
--   pattern = '*',
--   once = true,
--   nested = true,
--   callback = function()
--     vim.fn.chanclose(vim.g.neovide_channel_id)
--   end,
-- })

-- [[ Plugins ]]
-- Install lazy.nvim
-- see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazy_path) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    repo,
    lazy_path,
  }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazy_path)

-- Load plugins
require('lazy').setup {
  { import = 'plugins' },
}

-- [[ Modeline ]]
-- vim: ts=2 sts=2 sw=2 et

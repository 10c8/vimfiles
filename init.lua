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

  vim.g.neovide_hide_mouse_when_typing = true

  -- Keymaps
  -- vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Copy to clipboard' })

  -- vim.api.nvim_set_keymap('', '<C-v>', '+p<CR>', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('!', '<C-v>', '<C-R>+', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('i', '<C-v>', '<C-R>+', { noremap = true, silent = true })
  -- vim.api.nvim_set_keymap('v', '<C-v>', '<C-R>+', { noremap = true, silent = true })

  -- Animations
  vim.g.neovide_position_animation_length = 0.0
  vim.g.neovide_scroll_animation_length = 0.0
  vim.g.neovide_scroll_animation_far_lines = 0
end

-- [[ Keymaps ]]
-- Highlight on search, clear on escape
vim.opt.hlsearch = true
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>')

-- Navigation
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Move half page [u]p' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Move half page [d]own' })

-- Diagnostic navigation
vim.keymap.set('n', '[d', function()
  local diag = vim.diagnostic.get_prev()
  if diag then
    vim.diagnostic.jump { diagnostic = diag }
  end
end, { noremap = true, desc = 'Go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', function()
  local diag = vim.diagnostic.get_next()
  if diag then
    vim.diagnostic.jump { diagnostic = diag }
  end
end, { noremap = true, desc = 'Go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, desc = 'Show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap = true, desc = 'Open diagnostic [q]uickfix list' })

-- Fix the delay when closing a buffer
vim.keymap.del('n', '<C-w><C-d>')
vim.keymap.del('n', '<C-w>d')
vim.keymap.del('i', '<C-w>')

vim.keymap.set('n', '<leader>w', '<C-w>', { noremap = true })

-- Buffers
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true, desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true, desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true, desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true, desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-n>', '<CMD>enew<CR>', { noremap = true, desc = 'New empty buffer' })
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
end, { noremap = true, desc = 'Edit in a new buffer' })
vim.keymap.set('n', '<C-w>', '<CMD>bd<CR>', { noremap = true, desc = 'Close the current buffer' })
vim.keymap.set('n', '<C-S-w>', '<CMD>bd!<CR>', { noremap = true, desc = 'Close the current buffer (force)' })

-- Splits
vim.keymap.set('n', '<leader>vh', '<CMD>split<CR>', { noremap = true, desc = 'Split the window [h]orizontally' })
vim.keymap.set('n', '<leader>vv', '<CMD>vsplit<CR>', { noremap = true, desc = 'Split the window [v]ertically' })

-- Saving
vim.keymap.set('n', 'zz', '<CMD>update<CR>', { noremap = true, desc = 'Update the current file' })

-- [[ Autocommands ]]
-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('yank-highlight', { clear = true }),
  callback = vim.highlight.on_yank,
})

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

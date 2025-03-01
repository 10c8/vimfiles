-- [[ Callbacks ]]
local function prev_diag_msg()
  local diag = vim.diagnostic.get_prev()
  if diag then
    vim.diagnostic.jump { diagnostic = diag }
  end
end

local function next_diag_msg()
  local diag = vim.diagnostic.get_next()
  if diag then
    vim.diagnostic.jump { diagnostic = diag }
  end
end

-- [[ Keymaps ]]
local keymaps = {
  -- Neovim
  ['<C-u>'] = { 'Scroll half page [u]p', 'n', '<C-u>zz' },
  ['<C-d>'] = { 'Scroll half page [d]own', 'n', '<C-d>zz' },
  ['[d'] = { 'Go to previous [d]iagnostic message', 'n', prev_diag_msg },
  [']d'] = { 'Go to next [d]iagnostic message', 'n', next_diag_msg },
  ['<leader>e'] = { 'Show diagnostic [e]rror messages', 'n', vim.diagnostic.open_float },
  ['<leader>q'] = { 'Open diagnostic [q]uickfix list', 'n', vim.diagnostic.setloclist },
  ['<leader>wd'] = { 'Show hovered [d]iagnostic', 'n', '<C-w>d' },
  ['<C-h>'] = { 'Move focus to the left window', 'n', '<C-w><C-h>' },
  ['<C-l>'] = { 'Move focus to the right window', 'n', '<C-w><C-l>' },
  ['<C-j>'] = { 'Move focus to the lower window', 'n', '<C-w><C-j>' },
  ['<C-k>'] = { 'Move focus to the upper window', 'n', '<C-w><C-k>' },
  ['<C-n>'] = { 'New empty buffer', 'n', '<CMD>enew<CR>' },
  ['<C-w>'] = { 'Close the current buffer', 'n', '<CMD>bp<CR><CMD>bd #<CR>' },
  ['<C-S-w>'] = { 'Close the current buffer (force)', 'n', '<CMD>bp<CR><CMD>bd! #<CR>' },
  ['<leader>vh'] = { 'Split the window [h]orizontally', 'n', '<CMD>split<CR>' },
  ['<leader>vv'] = { 'Split the window [v]ertically', 'n', '<CMD>vsplit<CR>' },
  ['zz'] = { 'Update the current file', 'n', '<CMD>update<CR>' },
}

-- Clear search highlights on `Esc`
vim.keymap.set('n', '<ESC>', '<CMD>nohlsearch<CR>')

-- Fix the delay when closing a buffer using `<C-w>`
vim.keymap.del('n', '<C-w><C-d>')
vim.keymap.del('n', '<C-w>d')
vim.keymap.del('i', '<C-w>')

-- Apply keymaps
for keys, data in pairs(keymaps) do
  local desc, modes, callback = unpack(data)

  vim.keymap.set(modes, keys, callback, { noremap = true, desc = desc })
end

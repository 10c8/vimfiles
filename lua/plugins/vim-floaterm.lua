return {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_shell = 'pwsh'
    vim.g.floaterm_title = 'Terminal ($1/$2)'
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = 'bottomright'
    vim.g.floaterm_autoclose = 0
    vim.g.floaterm_autoinsert = false
    vim.g.floaterm_titleposition = 'center'

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x' }, '<leader>tt', '<cmd>FloatermToggle<CR>', { desc = '[t]oggle the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tn', '<cmd>FloatermNew<CR>', { desc = 'Open a [n]ew terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tk', '<cmd>FloatermKill<CR>', { desc = '[k]ill a terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t[', '<cmd>FloatermPrev<CR>', { desc = 'Cycle to the previous terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t]', '<cmd>FloatermNext<CR>', { desc = 'Cycle to the next terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tg', '<cmd>FloatermNew lazygit<CR>', { desc = 'Open a [g]it terminal' })

    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n><cmd>FloatermHide<CR>', { desc = 'Exit terminal mode' })
  end,
}

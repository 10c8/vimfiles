return {
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_shell = 'pwsh'
    vim.g.floaterm_title = 'Terminal ($1/$2)'
    vim.g.floaterm_width = 80
    vim.g.floaterm_height = 25
    vim.g.floaterm_position = 'bottomright'
    vim.g.floaterm_autoclose = 0
    vim.g.floaterm_autoinsert = false
    vim.g.floaterm_titleposition = 'center'

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x' }, '<leader>tt', '<cmd>FloatermToggle<CR>', { desc = '[t]oggle the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tn', '<cmd>FloatermNew<CR>', { desc = 'Open a [n]ew terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>th', '<cmd>FloatermHide<CR>', { desc = '[h]ide the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tk', '<cmd>FloatermKill<CR>', { desc = '[k]ill a terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ts', '<cmd>FloatermUpdate --wintype=vsplit --position=rightbelow<CR>', { desc = '[s]plit the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tf', '<cmd>FloatermUpdate --wintype=float --position=bottomright<CR>', { desc = '[f]loat the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t[', '<cmd>FloatermPrev<CR>', { desc = 'Cycle to the previous terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t]', '<cmd>FloatermNext<CR>', { desc = 'Cycle to the next terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tg', function()
      vim.g.floaterm_autoinsert = true
      vim.cmd 'FloatermNew --name=Lazygit --title=Lazygit --width=0.8 --height=0.8 --position=center --autoclose=2 lazygit'
      vim.g.floaterm_autoinsert = false
    end, { desc = 'Open the Lazy[g]it terminal' })

    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })
  end,
}

-- [[
-- Embedded floating terminal (used for `lazygit` as well.)
-- ]]

return {
  'voldikss/vim-floaterm',
  lazy = true,
  event = 'VimEnter',
  config = function()
    vim.g.floaterm_shell = 'pwsh'
    vim.g.floaterm_title = 'Terminal ($1/$2)'
    vim.g.floaterm_height = 12
    vim.g.floaterm_wintype = 'split'
    vim.g.floaterm_autoclose = 0
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_titleposition = 'center'

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x' }, '<C-Space>', '<CMD>FloatermToggle<CR>', { desc = '[t]oggle the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tt', '<CMD>FloatermNew<CR>', { desc = 'Open a [n]ew terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>th', '<CMD>FloatermHide<CR>', { desc = '[h]ide the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tk', '<CMD>FloatermKill<CR>', { desc = '[k]ill a terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ts', '<CMD>FloatermUpdate --wintype=vsplit --position=rightbelow<CR>', { desc = '[s]plit the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tf', '<CMD>FloatermUpdate --wintype=float --position=bottomright<CR>', { desc = '[f]loat the terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t[', '<CMD>FloatermPrev<CR>', { desc = 'Cycle to the previous terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>t]', '<CMD>FloatermNext<CR>', { desc = 'Cycle to the next terminal' })
    vim.keymap.set({ 'n', 'x' }, '<leader>tg', function()
      vim.g.floaterm_wintype = 'float'
      vim.cmd 'FloatermNew --name=Lazygit --title=Lazygit --width=0.9 --height=0.9 --position=center --autoclose=2 lazygit'
      vim.g.floaterm_wintype = 'split'
    end, { desc = 'Open the Lazy[g]it terminal' })

    -- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal' })

    -- [[ Autocommands ]]
    local group = vim.api.nvim_create_augroup('Floaterm', { clear = true })

    vim.api.nvim_create_autocmd('TermOpen', {
      group = group,
      callback = function()
        vim.cmd 'setlocal listchars= nonumber norelativenumber nocursorline signcolumn=no'

        vim.keymap.set('t', '<C-Space>', '<C-\\><C-n><CMD>FloatermToggle<CR>', { buffer = true, desc = '[t]oggle the terminal' })
      end,
    })
  end,
}

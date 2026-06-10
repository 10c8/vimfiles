-- [[
-- Embedded floating terminal (used for `lazygit` as well.)
-- ]]

return {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermNew', 'FloatermToggle', 'FloatermHide', 'FloatermKill', 'FloatermUpdate', 'FloatermPrev', 'FloatermNext' },
  keys = {
    { '<C-Space>', '<CMD>FloatermToggle<CR>', mode = { 'n', 'x' }, desc = '[t]oggle the terminal' },
    { '<leader>tt', '<CMD>FloatermNew<CR>', mode = { 'n', 'x' }, desc = 'Open a [n]ew terminal' },
    { '<leader>th', '<CMD>FloatermHide<CR>', mode = { 'n', 'x' }, desc = '[h]ide the terminal' },
    { '<leader>tk', '<CMD>FloatermKill<CR>', mode = { 'n', 'x' }, desc = '[k]ill a terminal' },
    { '<leader>ts', '<CMD>FloatermUpdate --wintype=vsplit --position=rightbelow<CR>', mode = { 'n', 'x' }, desc = '[s]plit the terminal' },
    { '<leader>tf', '<CMD>FloatermUpdate --wintype=float --position=bottomright<CR>', mode = { 'n', 'x' }, desc = '[f]loat the terminal' },
    { '<leader>t[', '<CMD>FloatermPrev<CR>', mode = { 'n', 'x' }, desc = 'Cycle to the previous terminal' },
    { '<leader>t]', '<CMD>FloatermNext<CR>', mode = { 'n', 'x' }, desc = 'Cycle to the next terminal' },
    { '<leader>tg', function()
      vim.g.floaterm_wintype = 'float'
      vim.cmd 'FloatermNew --name=Lazygit --title=Lazygit --width=0.9 --height=0.9 --position=center --autoclose=2 lazygit'
      vim.g.floaterm_wintype = 'split'
    end, mode = { 'n', 'x' }, desc = 'Open the Lazy[g]it terminal' },
  },
  init = function()
    vim.g.floaterm_shell = 'pwsh'
    vim.g.floaterm_title = 'Terminal ($1/$2)'
    vim.g.floaterm_height = 12
    vim.g.floaterm_wintype = 'split'
    vim.g.floaterm_autoclose = 0
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_titleposition = 'center'
  end,
  config = function()

    -- [[ Autocommands ]]
    local group = vim.api.nvim_create_augroup('Floaterm', { clear = true })

    vim.api.nvim_create_autocmd('TermOpen', {
      group = group,
      callback = function()
        vim.cmd 'setlocal listchars= nonumber norelativenumber nocursorline signcolumn=no'

        vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { buffer = true, desc = 'Exit terminal' })
        vim.keymap.set('t', '<C-Space>', '<C-\\><C-n><CMD>FloatermToggle<CR>', { buffer = true, desc = '[t]oggle terminal' })
      end,
    })
  end,
}

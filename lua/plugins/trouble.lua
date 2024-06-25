-- [[
-- UI for managing LSP diagnostics.
-- ]]

return {
  'folke/trouble.nvim',
  lazy = true,
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>xx',
      '<CMD>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'Toggle diagnostics for current buffer',
    },
    {
      '<leader>xw',
      '<CMD>Trouble diagnostics toggle<CR>',
      desc = 'Toggle diagnostics for [w]orkspace',
    },
  },
  opts = {
    focus = true,
  },
  init = function()
    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    }
  end,
}

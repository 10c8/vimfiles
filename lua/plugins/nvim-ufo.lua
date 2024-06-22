return {
  'kevinhwang91/nvim-ufo',
  lazy = true,
  event = 'BufRead',
  dependencies = {
    'kevinhwang91/promise-async',
    'neovim/nvim-lspconfig',
  },
  config = function()
    local ufo = require 'ufo'
    ufo.setup()

    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- [[ Keymaps ]]
    vim.keymap.set('n', 'zO', ufo.openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zC', ufo.closeAllFolds, { desc = 'Close all folds' })
  end,
}

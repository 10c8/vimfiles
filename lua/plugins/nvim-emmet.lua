return {
  'olrtg/nvim-emmet',
  lazy = true,
  ft = {
    'html',
    'css',
    'scss',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'vue',
    'markdown',
  },
  config = function()
    local nvim_emmet = require 'nvim-emmet'

    -- Keymaps
    vim.keymap.set({ 'n', 'v' }, '<leader>xe', function()
      nvim_emmet.wrap_with_abbreviation()
    end)
  end,
}

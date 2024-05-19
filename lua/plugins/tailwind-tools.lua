return {
  'luckasRanarison/tailwind-tools.nvim',
  lazy = true,
  ft = {
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
    'vue',
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local tt = require('tailwind-tools')

    tt.setup {
      document_color = {
        enabled = true,
        kind = 'inline',
        inline_symbol = '󰝤 ',
        debounce = 200,
      },
      conceal = {
        enabled = false,
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>TS', '<cmd>:TailwindSort<cr>', { noremap = true, silent = true })
  end,
}

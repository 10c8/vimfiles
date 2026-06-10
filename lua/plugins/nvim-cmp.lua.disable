-- [[
-- Auto-completions.
-- ]]

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',
    -- { 'zbirenbaum/copilot-cmp', opts = {} },
  },
  config = function()
    -- see `:help cmp`
    local cmp = require 'cmp'

    cmp.setup {
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- formatting = {
      --   format = require('lspkind').cmp_format {
      --     before = require('tailwind-tools.cmp').lspkind_format,
      --   },
      -- },

      -- [[ Keymaps ]]
      -- see `:help ins-completion`
      mapping = cmp.mapping.preset.insert {
        -- Select the next item
        ['<C-j>'] = cmp.mapping.select_next_item(),
        -- Select the previous item
        ['<C-k>'] = cmp.mapping.select_prev_item(),

        -- Accept the completion
        ['<CR>'] = cmp.mapping.confirm { select = true },

        -- Close the completion menu
        ['<C-e>'] = cmp.mapping.close(),

        -- Manually trigger a completion from nvim-cmp
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Scrolling
        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping.scroll_docs(4),
      },

      sources = {
        -- { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'path' },
      },
    }
  end,
}

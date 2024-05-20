return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind-nvim',
    -- 'luckasRanarison/tailwind-tools.nvim',
    -- { 'zbirenbaum/copilot-cmp', opts = {} },
    -- 'rafamadriz/friendly-snippets',
  },
  config = function()
    -- see `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = { completeopt = 'menu,menuone,noinsert' },

      -- formatting = {
      --   format = require('lspkind').cmp_format({
      --     before = require('tailwind-tools.cmp').lspkind_format
      --   })
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

        -- Snippet navigation
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },

      sources = {
        -- { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
    }
  end,
}

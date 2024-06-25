-- [[
-- Faster Lua LSP.
-- ]]

return {
  'folke/lazydev.nvim',
  dependencies = {
    {
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0,
        })
      end,
    },
  },
  lazy = true,
  ft = 'lua',
  opts = {},
}

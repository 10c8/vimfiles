-- [[
-- Faster Lua LSP.
-- ]]

return {
  'folke/lazydev.nvim',
  dependencies = {
    {
      'saghen/blink.cmp',
      opts = {
        sources = {
          default = { 'lazydev' },
          providers = {
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          },
        },
      },
    },
  },
  lazy = true,
  ft = 'lua',
  opts = {},
}

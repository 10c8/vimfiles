-- [[
-- Git decorations on the signcolumn.
-- ]]

return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = 'VeryLazy',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}

return {
  'chrishrb/gx.nvim',
  lazy = true,
  event = 'BufRead',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { 'gx', '<CMD>Browse<CR>', mode = { 'n', 'x' } },
  },
  config = true,
}

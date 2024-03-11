return {
  'chrishrb/gx.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { 'gx', '<CMD>Browse<CR>', mode = { 'n', 'x' } },
  },
  config = true,
}

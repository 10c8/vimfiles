return {
  'm4xshen/smartcolumn.nvim',
  lazy = true,
  event = 'BufReadPre',
  opts = {
    scope = 'window',
    custom_colorcolumn = {
      cs = '100',
      rust = '100',
    },
    disabled_filetypes = {
      'help',
      'text',
      'markdown',
      'lazy',
      'mason',
      'checkhealth',
      'lspinfo',
      'noice',
      'Trouble',
    },
  },
}

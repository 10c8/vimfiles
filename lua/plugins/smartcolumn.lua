return {
  'm4xshen/smartcolumn.nvim',
  lazy = true,
  event = 'BufReadPre',
  opts = {
    scope = 'window',
    custom_colorcolumn = {
      markdown = '80',
      rust = '100',
    },
    disabled_filetypes = {
      'help',
      'text',
      'lazy',
      -- 'mason',
      'checkhealth',
      'lspinfo',
      'noice',
      -- 'Trouble',
    },
  },
}

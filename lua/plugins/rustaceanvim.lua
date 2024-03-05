return {
  'mrcjkb/rustaceanvim',
  ft = { 'rust' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ['rust-analyzer'] = {
            inlayHints = {
              closingBraceHints = { enable = true },
              parameterHints = { enable = false },
              typeHints = { enable = false },
            },
          },
        },
      },
    }
  end,
}

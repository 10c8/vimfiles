return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine',
  },
  opts = {
    options = {
      theme = 'gruvbox-material',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch',
        'diff',
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
          symbols = {
            error = ' ',
            warn = ' ',
            hint = ' ',
            info = ' ',
          },
        },
      },
      lualine_c = { 'filename' },
      lualine_x = { 'copilot', 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}

return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        indicator = {
          style = 'underline',
        },
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'NvimTree',
            text = '',
            separator = false,
          },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'slant',
        sort_by = 'insert_at_end',
      },
    }
  end,
}
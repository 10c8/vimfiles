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
        diagnostics_indicator = function(_, _, diagnostics_dict, context)
          if context.buffer:current() then
            return ''
          end

          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
            s = s .. n .. sym
          end
          return s
        end,
        custom_filter = function(buf_number, _)
          -- Hide the `mini.files` buffer
          return true -- TODO
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        sort_by = 'insert_at_end',
      },
    }
  end,
}

-- [[
-- A snazzy bufferline for Neovim.
-- ]]

return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local bufferline = require 'bufferline'

    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        indicator = {
          style = 'icon',
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
        custom_filter = function(buf_number)
          local ft = vim.bo[buf_number].filetype
          -- Hide floaterm buffers
          if ft == 'floaterm' then
            return false
          end
          return true
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<S-L>', '<CMD>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Switch to the next buffer' })
    vim.keymap.set('n', '<S-H>', '<CMD>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Switch to the previous buffer' })
    vim.keymap.set('n', '<Leader><S-L>', '<CMD>BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = 'Move buffer to the right' })
    vim.keymap.set('n', '<Leader><S-H>', '<CMD>BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = 'Move buffer to the left' })
    vim.keymap.set('n', 'gB', '<CMD>BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Pick a [B]uffer' })
  end,
}

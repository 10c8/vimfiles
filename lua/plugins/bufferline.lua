-- [[
-- A snazzy bufferline for Neovim.
-- ]]

return {
  'akinsho/bufferline.nvim',
  lazy = true,
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    if vim.g.vscode then
      return
    end

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
        -- custom_filter = function(_buf_number, _)
        --   -- Hide the `mini.files` buffer
        --   return true -- TODO
        -- end,
        show_buffer_close_icons = false,
        show_close_icon = false,
        sort_by = 'insert_at_end',
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<TAB>', '<CMD>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Switch to the next buffer' })
    vim.keymap.set('n', '<S-TAB>', '<CMD>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Switch to the previous buffer' })
    vim.keymap.set('n', '<Leader><TAB>', '<CMD>BufferLineMoveNext<CR>', { noremap = true, silent = true, desc = 'Move buffer to the right' })
    vim.keymap.set('n', '<Leader><S-TAB>', '<CMD>BufferLineMovePrev<CR>', { noremap = true, silent = true, desc = 'Move buffer to the left' })
    vim.keymap.set('n', 'gB', '<CMD>BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Pick a [B]uffer' })
  end,
}

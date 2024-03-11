return {
  'rmagatti/goto-preview',
  config = function()
    local gp = require 'goto-preview'

    gp.setup {
      default_mappings = false,
      opacity = 0,
      dismiss_on_move = true,
      preview_window_title = {
        enable = true,
        position = 'center',
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', 'gd', function()
      gp.goto_preview_definition {}

      vim.keymap.set('', 'q', function()
        gp.close_all_win()
      end, { buffer = true, noremap = true, silent = true, desc = 'Close preview window' })
    end, { noremap = true, desc = 'Peek [d]efinition' })
  end,
}

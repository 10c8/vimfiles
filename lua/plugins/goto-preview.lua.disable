return {
  'rmagatti/goto-preview',
  lazy = true,
  event = 'BufRead',
  config = function()
    local gp = require 'goto-preview'

    gp.setup {
      default_mappings = false,
      opacity = 0,
      -- dismiss_on_move = true,
      preview_window_title = {
        enable = true,
        position = 'center',
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', 'gd', function()
      gp.goto_preview_definition {}

      vim.defer_fn(function()
        vim.keymap.set('', 'q', function()
          gp.close_all_win()
        end, { buffer = true, noremap = true, silent = true, desc = 'Close preview window' })
      end, 200)
    end, { noremap = true, desc = 'Peek [d]efinition' })
  end,
}

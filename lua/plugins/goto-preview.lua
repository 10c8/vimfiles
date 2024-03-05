return {
  'rmagatti/goto-preview',
  config = function()
    local gp = require 'goto-preview'

    gp.setup {
      default_mappings = false,
      opacity = 0,
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

        vim.keymap.del('', 'q')
      end, { noremap = true, silent = true, desc = 'Close preview window' })
    end, { noremap = true, desc = 'Peek [d]efinition' })
  end,
}

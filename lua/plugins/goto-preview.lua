-- [[
-- Preview window for LSP symbol definitions.
-- ]]

return {
  'rmagatti/goto-preview',
  lazy = true,
  event = 'LspAttach',
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
    -- TODO: Figure out the proper way to bind `q` to close the preview popup
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

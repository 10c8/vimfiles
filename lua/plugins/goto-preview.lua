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
      post_open_hook = function(buffer, _)
        vim.keymap.set('', 'q', gp.close_all_win, { buffer = buffer, noremap = true, silent = true, desc = 'Close preview window' })
      end,
    }

    -- [[ Keymaps ]]
    -- TODO: Figure out the proper way to bind `q` to close the preview popup
    vim.keymap.set('n', 'gd', gp.goto_preview_definition, { noremap = true, desc = 'Peek [d]efinition' })
  end,
}

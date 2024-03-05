return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    local tree = require 'nvim-tree'

    tree.setup {
      filters = {
        custom = { '^.git$' }, -- Hide the .git directory
      },
      renderer = {
        icons = {
          show = {
            git = true,
            file = true,
            folder = false,
          },
          glyphs = {
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '⌥',
              renamed = '➜',
              untracked = '★',
              deleted = '⊖',
              ignored = '◌',
            },
          },
        },
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle the file [B]rowser' })
  end,
}

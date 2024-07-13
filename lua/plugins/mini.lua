-- [[
-- Mini plugins.
--  - AI: Better [A]round/[I]nside textobjects.
--  - Surround: Add/delete/replace surroundings (brackets, quotes, etc.)
--  - Pairs: Automatically close pairs (brackets, quotes, etc.)
--  - Move: Move lines and blocks of text.
--  - Trailspace: Highlight trailing whitespaces.
--  - Files: Simple file explorer.
--  - Sessions: Save and restore sessions.
-- ]]

return {
  'echasnovski/mini.nvim',
  version = false,
  lazy = true,
  event = 'VimEnter',
  specs = {
    { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
  },
  config = function()
    -- va)  - [V]isually select [A]round [)]paren
    -- yinq - [Y]ank [I]nside [N]ext [']quote
    -- ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- sd'   - [S]urround [D]elete [']quotes
    -- sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {}

    require('mini.pairs').setup {}

    require('mini.move').setup {}

    require('mini.trailspace').setup {}

    require('mini.splitjoin').setup {}

    local files = require 'mini.files'
    files.setup {
      content = {
        filter = function(fs_entry)
          return fs_entry ~= '.git' -- Hide `.git` directory
        end,
      },
    }

    local sessions = require 'mini.sessions'
    sessions.setup {
      autoread = true,
      autowrite = true,
      file = '.session.vim',
    }

    local icons = require 'mini.icons'

    package.preload['nvim-web-devicons'] = function()
      package.loaded['nvim-web-devicons'] = {}
      icons.mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end

    icons.setup {}

    -- [[ Keymaps ]]
    -- Open mini files explorer
    vim.keymap.set('n', '<C-b>', function()
      if not files.close() then
        files.open()
      end
    end, { desc = 'Open file [b]rowser' })

    -- Sessions
    vim.keymap.set('n', '<leader>pp', function()
      sessions.write(sessions.config.file, nil)
    end, { desc = 'Save local [p]roject' })

    vim.keymap.set('n', '<leader>pl', function()
      sessions.read(sessions.config.file, nil)
    end, { desc = '[l]oad local [p]roject' })

    vim.keymap.set('n', '<leader>pd', function()
      sessions.delete(sessions.config.file, nil)
    end, { desc = '[d]elete local [p]roject' })
  end,
}

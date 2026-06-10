-- [[
-- Mini plugins.
-- ]]

return {
  'echasnovski/mini.nvim',
  version = '*',
  lazy = true,
  event = 'VimEnter',
  specs = {
    { 'nvim-tree/nvim-web-devicons', enabled = false, optional = true },
  },
  config = function()
    -- AI: Better [A]round/[I]nside textobjects
    -- va)  - [V]isually select [A]round [)]paren
    -- yinq - [Y]ank [I]nside [N]ext [']quote
    -- ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Surround: Add/delete/replace surroundings (brackets, quotes, etc.)
    -- saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- sd'   - [S]urround [D]elete [']quotes
    -- sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {}

    -- Pairs: Automatically close pairs (brackets, quotes, etc.)
    require('mini.pairs').setup {}

    -- Move: Move lines and blocks of text
    require('mini.move').setup {}

    -- Trailspace: Highlight trailing whitespaces
    require('mini.trailspace').setup {}

    -- Split and join arguments (reverse <S-J>)
    require('mini.splitjoin').setup {
      toggle = 'gS',
    }

    -- Files: Simple file explorer
    local files = require 'mini.files'
    files.setup {
      content = {
        filter = function(fs_entry)
          return fs_entry ~= '.git' -- Hide `.git` directory
        end,
      },
    }

    -- Sessions: Save and restore sessions
    local sessions = require 'mini.sessions'
    sessions.setup {
      autoread = true,
      autowrite = true,
      file = '.session.vim',
    }

    -- Icon provider
    local icons = require 'mini.icons'

    package.preload['nvim-web-devicons'] = function()
      package.loaded['nvim-web-devicons'] = {}
      icons.mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end

    icons.setup {}

    -- [[ Keymaps ]]
    -- File browser
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

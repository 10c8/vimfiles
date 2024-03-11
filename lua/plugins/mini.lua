return {
  'echasnovski/mini.nvim',
  config = function()
    -- AI
    -- Better [A]round/[I]nside textobjects
    --
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup {
      n_lines = 500,
    }

    -- Surround
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Trailspace
    -- Trim all trailing whitespace with `MiniTrailspace.trim()`.
    -- TODO: Call `MiniTrailspace.trim()` on save.
    require('mini.trailspace').setup()

    -- Pairs
    -- Automatically close pairs (brackets, quotes, etc.)
    require('mini.pairs').setup()

    -- Move
    -- Move lines and blocks of text
    require('mini.move').setup()

    -- Files
    -- Simple file explorer
    local files = require 'mini.files'
    files.setup {
      content = {
        filter = function(fs_entry)
          return fs_entry ~= '.git' -- Hide `.git` directory
        end,
      },
    }

    -- Minimap
    -- Code minimap
    local map = require 'mini.map'

    map.setup {
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot '4x2',
      },
      window = {
        focusable = true,
        width = 14,
      },
    }

    -- Sessions
    -- Save and restore sessions
    local sessions = require 'mini.sessions'

    sessions.setup {
      autoread = true,
      autowrite = true,
      file = '.session.vim',
    }

    -- [[ Keymaps ]]
    -- Open mini files explorer
    vim.keymap.set('', '<C-b>', function()
      if not files.close() then
        files.open()
      end
    end, { desc = 'Open file {b}rowser' })

    -- Minimap
    vim.keymap.set('n', '<leader>mm', map.toggle, { desc = 'Toggle [M]ini [M]ap' })
    vim.keymap.set('n', '<leader>mc', map.close, { desc = '[M]inimap [C]lose' })
    vim.keymap.set('n', '<leader>mf', map.toggle_focus, { desc = 'Toggle [M]inimap [F]ocus' })
    vim.keymap.set('n', '<leader>mo', map.open, { desc = '[M]inimap [O]pen' })
    vim.keymap.set('n', '<leader>mr', map.refresh, { desc = '[M]inimap [R]efresh' })
    vim.keymap.set('n', '<leader>ms', map.toggle_side, { desc = 'Toggle [M]inimap [S]ide' })

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

    -- [[ Autocommands ]]
    local minimap_autocmd_group = vim.api.nvim_create_augroup('mini.map', { clear = true })

    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Open minimap on VimEnter',
      group = minimap_autocmd_group,
      callback = function()
        local winwidth = vim.fn.winwidth(0)
        if winwidth > 100 then
          map.open()
        end
      end,
    })

    vim.api.nvim_create_autocmd('VimResized', {
      desc = 'Handle minimap on VimResized',
      group = minimap_autocmd_group,
      callback = function()
        local winwidth = vim.fn.winwidth(0)
        if winwidth > 100 then
          map.open()
        else
          map.close()
        end
      end,
    })
  end,
}

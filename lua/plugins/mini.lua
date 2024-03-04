return {
  'echasnovski/mini.nvim',
  config = function()
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

    -- Tabline
    require('mini.tabline').setup()

    -- Minimap
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
        width = 12,
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>mm', map.toggle, { desc = 'Toggle [M]ini [M]ap' })
    vim.keymap.set('n', '<leader>mc', map.close, { desc = '[M]inimap [C]lose' })
    vim.keymap.set('n', '<leader>mf', map.toggle_focus, { desc = 'Toggle [M]inimap [F]ocus' })
    vim.keymap.set('n', '<leader>mo', map.open, { desc = '[M]inimap [O]pen' })
    vim.keymap.set('n', '<leader>mr', map.refresh, { desc = '[M]inimap [R]efresh' })
    vim.keymap.set('n', '<leader>ms', map.toggle_side, { desc = 'Toggle [M]inimap [S]ide' })

    -- [[ Autocommands ]]
    vim.api.nvim_create_autocmd('VimEnter', {
      desc = 'Open minimap on VimEnter',
      group = vim.api.nvim_create_augroup('minimap-vimenter', { clear = true }),
      callback = map.open,
    })
  end,
}

return {
  'AckslD/nvim-neoclip.lua',
  lazy = true,
  event = 'VimEnter',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- { 'kkharji/sqlite.lua', module = 'sqlite' },
  },
  config = function()
    require('neoclip').setup {
      history = 1000,
      -- enable_persistent_history = true,
      -- db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
      default_register = { '"', '+', '*' },
      default_register_macros = 'q',
      on_select = {
        move_to_front = true,
      },
      on_replay = {
        move_to_front = true,
      },
    }
  end,
}

return {
  'AckslD/nvim-neoclip.lua',
  config = function()
    require('neoclip').setup {
      default_register = { '"', '+', '*' },
      on_select = {
        move_to_front = true,
      },
      on_replay = {
        move_to_front = true,
      },
    }
  end,
}

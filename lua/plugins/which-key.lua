-- [[
-- Lists possible keybindings when you start typing a command.
-- ]]

return {
  'folke/which-key.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local wk = require 'which-key'

    wk.setup {
      preset = 'modern',
    }

    wk.add {
      {
        '<leader>c',
        desc = '[c]ode',
        icon = {
          icon = '',
          color = 'blue',
        },
      },
      {
        '<leader>d',
        desc = '[d]ocument',
        icon = {
          icon = '',
          color = 'yellow',
        },
      },
      {
        '<leader>D',
        desc = '[D]ebugger',
        icon = {
          icon = '',
          color = 'red',
        },
      },
      {
        '<leader>p',
        desc = '[p]roject',
        icon = {
          icon = '',
          color = 'green',
        },
      },
      {
        '<leader>r',
        desc = 'Search and [r]eplace',
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>rb',
        desc = 'Search and [r]eplace (multi-[b]uffer)',
        icon = {
          icon = '',
          color = 'purple',
        },
      },
      {
        '<leader>s',
        desc = '[s]earch',
        icon = {
          icon = '',
          color = 'green',
        },
      },
      {
        '<leader>t',
        desc = '[t]erminal',
        icon = {
          icon = '',
          color = 'red',
        },
      },
      {
        '<leader>T',
        desc = '[T]ODOs / Tailwind',
        icon = {
          icon = '',
          color = 'blue',
        },
      },
      {
        '<leader>x',
        desc = 'Trouble',
        icon = {
          icon = '',
          color = 'red',
        },
      },
      {
        '<leader>v',
        desc = 'Split',
        icon = {
          icon = '',
          color = 'blue',
        },
      },
      {
        '<leader>w',
        desc = '[w]orkspace',
        icon = {
          icon = '',
          color = 'green',
        },
      },

      {
        'g',
        desc = '[g]oto',
        icon = {
          icon = '󱞫',
          color = 'orange',
        },
      },
    }
  end,
}

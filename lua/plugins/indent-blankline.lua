-- [[
-- Indentation guides (with cool colors).
-- ]]

local highlight = {
  'RainbowViolet',
  'RainbowBlue',
  'RainbowCyan',
  'RainbowGreen',
  'RainbowYellow',
  'RainbowOrange',
  'RainbowRed',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  tag = 'v3.8.2',
  lazy = true,
  event = 'BufReadPre',
  main = 'ibl',
  config = function()
    if vim.g.vscode then
      return
    end

    local hooks = require 'ibl.hooks'

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#d3869b' })
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#83a598' })
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#8ec07e' })
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#b8bb26' })
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#fabd2f' })
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#fe8019' })
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#fb4934' })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }

    require('ibl').setup {
      indent = {
        tab_char = '▎',
      },
      scope = {
        highlight = highlight,
        show_start = false,
        show_end = false,
      },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}

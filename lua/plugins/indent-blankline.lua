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
  main = 'ibl',
  config = function()
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
      scope = { highlight = highlight },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}

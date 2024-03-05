local highlight = {
  'RainbowRed',
  'RainbowOrange',
  'RainbowYellow',
  'RainbowGreen',
  'RainbowBlue',
  'RainbowViolet',
  'RainbowCyan',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = function()
    local hooks = require 'ibl.hooks'

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#e06c75' })
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e5c07b' })
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61afef' })
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#d19a66' })
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98c379' })
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c678dd' })
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56b6c2' })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    require('ibl').setup {
      scope = { highlight = highlight },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}

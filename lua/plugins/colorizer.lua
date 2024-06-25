-- [[
-- Highlights colors in code.
-- ]]

local ft = {
  'html',
  'css',
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

return {
  'NvChad/nvim-colorizer.lua',
  lazy = true,
  ft = ft,
  opts = {
    filetypes = ft,
    user_default_options = {
      names = false,
      css_fn = true,
      mode = 'virtualtext',
    },
  },
}

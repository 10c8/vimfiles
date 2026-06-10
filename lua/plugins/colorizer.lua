-- [[
-- Highlights colors in code.
-- ]]

local ft = {
  'css',
  'html',
  'javascript',
  'javascriptreact',
  'svelte',
  'typescript',
  'typescriptreact',
  'vue',
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

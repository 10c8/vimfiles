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
  event = 'BufRead',
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

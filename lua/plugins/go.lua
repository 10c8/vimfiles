-- [[
-- Go LSP.
-- ]]

return {
  'ray-x/go.nvim',
  -- '10c8/go.nvim',
  lazy = true,
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('go').setup()

    -- [[ Autocommands ]]
    local group = vim.api.nvim_create_augroup('GoFmt', {})

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      pattern = '*.go',
      callback = function()
        require('go.format').goimports()
      end,
    })
  end,
}

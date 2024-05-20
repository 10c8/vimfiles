return {
  "ray-x/go.nvim",
  lazy = true,
  event = { "CmdlineEnter" },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()',
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require('go').setup()

    -- [[ Keymaps ]]

    -- [[ Autocommands ]]
    local go_group = vim.api.nvim_create_augroup('GoFmt', {})

    vim.api.nvim_create_autocmd('BufWritePre', {
      group = go_group,
      pattern = '*.go',
      callback = function()
        require('go.format').goimports()
      end,
    })
  end,
}

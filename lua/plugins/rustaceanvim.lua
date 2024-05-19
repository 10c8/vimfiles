return {
  'mrcjkb/rustaceanvim',
  lazy = true,
  ft = { 'rust' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ['rust-analyzer'] = {
            imports = {
              granularity = { enforce = true },
            },
            inlayHints = {
              parameterHints = { enable = false },
              typeHints = { enable = false },
            },
          },
        },
      },
    }

    -- Underline mutable values
    vim.api.nvim_set_hl(0, '@lsp.mod.mutable', { underline = true })

    -- [[ Keymaps ]]
    -- Open `cargo.toml`
    vim.keymap.set('n', '<leader>rct', '<cmd>RustLsp openCargo<CR>', { silent = true, desc = '[r]ust: Edit [c]argo.[t]oml' })

    -- Expand macros recursively
    vim.keymap.set('n', '<leader>rem', '<cmd>RustLsp expandMacro<CR>', { silent = true, desc = '[r]ust: [e]xpand [m]acros recursively' })
  end,
}

-- [[
-- Rust LSP.
-- ]]

return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  lazy = false,
  ft = { 'rust' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, _)
          -- [[ Keymaps ]]
          -- Expand macros recursively
          vim.keymap.set('n', '<leader>rem', '<cmd>RustLsp expandMacro<CR>', { silent = true, desc = '[r]ust: [e]xpand [m]acros recursively' })
        end,
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
  end,
}

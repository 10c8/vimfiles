-- [[
-- Configs for code formatters.
-- ]]

return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufReadPre',
  ft = {
    'lua',
    'luau',
    'python',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'xml',
  },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format {
          timeout_ms = 500,
          lsp_fallback = true,
          async = true,
          quiet = true,
        }
      end,
      desc = '[f]ormat document',
    },
  },
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      lua = { 'stylua' },
      luau = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettierd', 'prettier' },
      javascriptreact = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', 'prettier' },
      vue = { 'prettierd', 'prettier' },
      -- xml = {
      --   {
      --     command = 'xmlformat',
      --     args = {
      --       '$FILENAME',
      --       '--indent 2',
      --       '--preserve "pre,literal"',
      --       '--blanks',
      --       '-outencoding "utf-8"',
      --     },
      --   },
      -- },
    },
    notify_on_error = false,
    format_after_save = {
      timeout_ms = 500,
      lsp_fallback = true,
      async = true,
      quiet = true,
    },
  },
}

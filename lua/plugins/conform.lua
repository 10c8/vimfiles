return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufReadPre',
  ft = {
    'lua',
    'python',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
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
      python = { 'black' },
      javascript = { 'prettierd', 'prettier' },
      javascriptreact = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', 'prettier' },
      vue = { 'prettierd', 'prettier' },
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

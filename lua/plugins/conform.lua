-- [[
-- Configs for code formatters.
-- ]]

return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  ft = {
    'lua',
    'luau',
    'javascript',
    'javascriptreact',
    'python',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format {
          lsp_format = 'never',
          async = true,
          quiet = true,
        }
      end,
      desc = '[f]ormat document',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      luau = { 'stylua' },
      python = { 'black' },
      javascript = { 'biome', 'biome-organize-imports' },
      javascriptreact = { 'biome', 'biome-organize-imports' },
      typescript = { 'biome', 'biome-organize-imports' },
      typescriptreact = { 'biome', 'biome-organize-imports' },
      svelte = { 'biome', 'biome-organize-imports' },
      vue = { 'biome', 'biome-organize-imports' },
    },
    notify_on_error = false,
    format_after_save = {
      timeout_ms = 500,
      lsp_format_opt = 'never',
      async = true,
      quiet = true,
    },
  },
}

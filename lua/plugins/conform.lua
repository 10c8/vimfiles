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
    'python',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'vue',
    'xml',
  },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format {
          -- timeout_ms = 500,
          -- lsp_fallback = true,
          lsp_format = 'never',
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
      javascript = { 'biome', 'biome-organize-imports' },
      javascriptreact = { 'biome', 'biome-organize-imports' },
      typescript = { 'biome', 'biome-organize-imports' },
      typescriptreact = { 'biome', 'biome-organize-imports' },
      svelte = { 'biome', 'biome-organize-imports' },
      vue = { 'biome', 'biome-organize-imports' },
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
      -- lsp_fallback = true,
      lsp_format_opt = "never",
      async = true,
      quiet = true,
    },
  },
}

return {
  'folke/trouble.nvim',
  lazy = true,
  cmd = 'TroubleToggle',
  event = 'BufReadPre',
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- local signs = {
    --   Error = ' ',
    --   Warn = ' ',
    --   Hint = ' ',
    --   Info = ' ',
    -- }

    -- for type, icon in pairs(signs) do
    --   local hl = 'DiagnosticSign' .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    -- end

    require('trouble').setup {
      height = 10,
      icons = false,
      mode = "loclist",
      auto_open = false,
      auto_close = false,
      auto_preview = true,
      auto_fold = false,
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>xx',
      "<cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>TroubleToggle<CR>",
      { silent = true, desc = 'Toggle the trouble list' })
    vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>',
      { silent = true, desc = 'Toggle the [w]orkspace diagnostics' })
    vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>',
      { silent = true, desc = 'Toggle the [d]ocument diagnostics' })
    vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>',
      { silent = true, desc = 'Toggle the [q]uickfix list' })
    -- vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<CR>', { desc = 'Toggle the [l]ocation list' })
    vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<CR>',
      { silent = true, desc = 'Toggle the LSP [R]eferences' })
  end,
}

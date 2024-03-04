return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("trouble").setup()

    local signs = {
      Error = ' ',
      Warn = ' ',
      Hint = ' ',
      Info = ' ',
    }

    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { desc = 'Toggle the trouble list' })
    vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Toggle the workspace diagnostics' })
    vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', { desc = 'Toggle the document diagnostics' })
    vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', { desc = 'Toggle the quickfix list' })
    vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<CR>', { desc = 'Toggle the location list' })
    vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<CR>', { desc = 'Toggle the LSP references' })
  end
}

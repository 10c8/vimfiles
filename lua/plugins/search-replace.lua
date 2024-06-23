return {
  'roobert/search-replace.nvim',
  lazy = true,
  event = 'BufRead',
  config = function()
    require('search-replace').setup {}

    vim.o.inccommand = 'split'

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>rs', '<CMD>SearchReplaceSingleBufferSelections<CR>', { desc = 'Search and [r]eplace: [s]election list', silent = true })
    vim.keymap.set('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWord<CR>', { desc = 'Search and [r]eplace: [w]ord', silent = true })
    vim.keymap.set('n', '<leader>rW', '<CMD>SearchReplaceSingleBufferCWORD<CR>', { desc = 'Search and [r]eplace: [W]ord (greedy)', silent = true })
    vim.keymap.set('n', '<leader>re', '<CMD>SearchReplaceSingleBufferCExpr<CR>', { desc = 'Search and [r]eplace: [e]xpression', silent = true })

    vim.keymap.set('n', '<leader>rbs', '<CMD>SearchReplaceMultiBufferSelections<CR>', { desc = 'Search and [r]eplace: [s]election list', silent = true })
    vim.keymap.set('n', '<leader>rbw', '<CMD>SearchReplaceMultiBufferCWord<CR>', { desc = 'Search and [r]eplace: [w]ord', silent = true })
    vim.keymap.set('n', '<leader>rbW', '<CMD>SearchReplaceMultiBufferCWORD<CR>', { desc = 'Search and [r]eplace: [W]ord (greedy)', silent = true })
    vim.keymap.set('n', '<leader>rbe', '<CMD>SearchReplaceMultiBufferCExpr<CR>', { desc = 'Search and [r]eplace: [e]xpression', silent = true })

    vim.keymap.set('v', '<C-r>', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>', { desc = 'Search and replace: Selection', silent = true })
    vim.keymap.set('v', '<C-s>', '<CMD>SearchReplaceWithinVisualSelection<CR>', { desc = 'Search and replace: Within Selection', silent = true })
    vim.keymap.set('v', '<C-b>', '<CMD>SearchReplaceWithinVisualSelectionCWord<CR>', { desc = 'Search and replace: Word Within Selection', silent = true })
  end,
}

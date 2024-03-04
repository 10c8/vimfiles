return {
  'rebelot/terminal.nvim',
  config = function()
    require('terminal').setup {
      layout = { open_cmd = "botright vertical new" },
      cmd = 'pwsh',
    }

    local term_map = require('terminal.mappings')

    -- [[ Keymaps ]]
    vim.keymap.set({ "n", "x" }, "<leader>ts", term_map.operator_send, { expr = true }, { desc = '[s]end text to a terminal' })
    vim.keymap.set('n', '<leader>tt', term_map.toggle, { desc = 'Open a [t]erminal' })
    vim.keymap.set('n', '<leader>tr', term_map.run, { desc = '[r]un a terminal command' })
    vim.keymap.set('n', '<leader>tk', term_map.kill, { desc = '[k]ill a terminal' })
    vim.keymap.set('n', '<leader>t]', term_map.cycle_next, { desc = 'Cycle to the next terminal' })
    vim.keymap.set('n', '<leader>t[', term_map.cycle_prev, { desc = 'Cycle to the previous terminal' })
    vim.keymap.set('n', '<leader>tf', term_map.move({ open_cmd = 'float' }), { desc = 'Move the terminal to a [f]loating window' })
  end,
}

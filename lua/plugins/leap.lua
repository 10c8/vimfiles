-- [[
-- Smart cursor motions on `f` and `F`.
-- ]]

return {
  'ggandor/leap.nvim',
  lazy = true,
  event = 'VimEnter',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    local leap = require 'leap'

    leap.opts.safe_labels = 'fnut/SFNLHMUGTZ?'

    leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

    leap.opts.special_keys.prev_target = '<bs>'
    leap.opts.special_keys.prev_group = '<bs>'

    require('leap.user').set_repeat_keys('<cr>', '<bs>', {
      relative_directions = true,
    })

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap-backward)', { desc = 'Leap backward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>(leap-from-window)', { desc = 'Leap (global)' })
  end,
}

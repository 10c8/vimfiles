return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    local leap = require 'leap'

    leap.opts.special_keys.prev_target = '<bs>'
    leap.opts.special_keys.prev_group = '<bs>'

    require('leap.user').set_repeat_keys('<cr>', '<bs>')

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap-backward)', { desc = 'Leap backward' })
  end,
}

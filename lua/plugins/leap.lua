-- [[
-- Smart cursor motions on `f` and `F`.
-- ]]

return {
  url = 'https://codeberg.org/andyg/leap.nvim',
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

    -- Skip preview for matches starting with whitespace or an alphabetic
    -- mid-word character: foobar[baaz] = quux
    --                     ^    ^^^  ^^ ^ ^  ^
    leap.opts.preview = function(ch0, ch1, ch2)
      return not (ch1:match '%s' or (ch0:match '%a' and ch1:match '%a' and ch2:match '%a'))
    end

    -- Highlight colors
    local colors = {
      fg = '#282828',
      bg = '#ebdbb2',
      bold = true,
      nocombine = true,
    }

    vim.api.nvim_set_hl(0, 'LeapLabel', colors)
    vim.api.nvim_set_hl(0, 'LeapLabelPrimary', colors)

    -- [[ Keymaps ]]
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', '<Plug>(leap-backward)', { desc = 'Leap backward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gf', '<Plug>(leap-from-window)', { desc = 'Leap (global)' })

    -- Enable the traversal keys to repeat the previous search without
    -- explicitly invoking Leap
    do
      local clever = require('leap.user').with_traversal_keys

      vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
        leap.leap {
          ['repeat'] = true,
          opts = clever('<cr>', '<bs>'),
        }
      end)
      vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
        leap.leap {
          ['repeat'] = true,
          opts = clever('<bs>', '<cr>'),
        }
      end)
    end
  end,
}

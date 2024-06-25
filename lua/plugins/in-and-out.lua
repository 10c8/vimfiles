-- [[
-- Get in and out of pairs, quotes, etc.
-- ]]

return {
  'ysmb-wtsg/in-and-out.nvim',
  lazy = true,
  event = 'InsertEnter',
  config = function()
    -- [[ Keymaps ]]
    vim.keymap.set('i', '<C-CR>', require('in-and-out').in_and_out)
  end,
}

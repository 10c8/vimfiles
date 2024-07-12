-- [[
-- GitHub Copilot.
-- ]]

return {
  'zbirenbaum/copilot.lua',
  lazy = true,
  event = 'InsertEnter',
  cmd = 'Copilot',
  config = function()
    require('copilot').setup {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 70,
        keymap = {
          accept = '<TAB>',
          accept_line = '<C-TAB>',
          next = '<C-S-j>',
          prev = '<C-S-k>',
          dismiss = '<C-c>',
        },
      },
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        ['.'] = false,
      },
    }
  end,
}

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
        keymap = {
          accept = '<TAB>',
          next = '<C-S-j>',
          prev = '<C-S-k>',
          dismiss = '<ESC>',
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

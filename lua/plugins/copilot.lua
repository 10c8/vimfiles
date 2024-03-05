return {
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        help = false,
        gitcommit = false,
        gitrebase = false,
        ['.'] = false,
      },
    }
  end,
}

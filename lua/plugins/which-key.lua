return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    local wk = require 'which-key'

    wk.setup()

    wk.register {
      ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
      ['<leader>m'] = { name = '[m]inimap', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = '[p]roject', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
      ['<leader>S'] = { name = '[S]plit', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[t]erminal', _ = 'which_key_ignore' },
      ['<leader>T'] = { name = '[T]ODOs', _ = 'which_key_ignore' },
      ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
      ['<leader>v'] = { name = '[v]imspector', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
    }
  end,
}

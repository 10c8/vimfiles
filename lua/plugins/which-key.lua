return {
  'folke/which-key.nvim',
  lazy = true,
  event = 'VimEnter',
  config = function()
    local wk = require('which-key')

    wk.setup()

    wk.register {
      ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
      ['<leader>D'] = { name = '[D]ebugger', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[g]oto', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = 'CoC [l]ist', _ = 'which_key_ignore', },
      ['<leader>m'] = { name = '[m]inimap', _ = 'which_key_ignore' },
      ['<leader>p'] = { name = '[p]roject', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[t]erminal', _ = 'which_key_ignore' },
      ['<leader>T'] = { name = '[T]ODOs', _ = 'which_key_ignore' },
      ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
      ['<leader>v'] = { name = 'Split', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
      ['<S-w>'] = { name = '[W]rite', _ = 'which_key_ignore' },
    }
  end,
}

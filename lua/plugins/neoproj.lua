return {
  'pluffie/neoproj',
  config = function()
    local neoproj = require 'neoproj'
    neoproj.setup {}

    neoproj.register_template {
      name = 'Empty project (git)',
      expand = 'git init',
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>pp', function()
      neoproj.open()
    end, { desc = 'Open [p]roject' })

    -- [[ Autocommands ]]
    vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
      desc = 'Save session on VimLeavePre',
      group = vim.api.nvim_create_augroup('neoproj-vimleavepre', { clear = true }),
      callback = function()
        if vim.g.project_root ~= nil then
          neoproj.save_session()
        end
      end,
    })
  end,
}

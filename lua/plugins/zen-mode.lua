return {
  'folke/zen-mode.nvim',
  ft = { 'markdown' },
  dependencies = {
    {
      'folke/twilight.nvim',
      opts = {
        context = 1,
      },
    },
  },
  config = function()
    local zen = require 'zen-mode'

    zen.setup {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
      },
    }

    -- [[ Keymaps ]]
    -- Toggle Zen Mode
    vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>', { silent = true, desc = 'Toggle [z]en mode' })

    -- [[ Autocommands ]]
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      desc = 'Enable Zen Mode automatically for some filetypes',
      callback = function()
        -- If this is a floating window, don't enable Zen Mode
        if vim.api.nvim_win_get_config(0).relative ~= '' then
          return
        end

        vim.defer_fn(function()
          zen.toggle()

          -- Set scroll offset to 999 to center the cursor vertically
          vim.api.nvim_set_option_value('scrolloff', 999, { scope = 'local' })
        end, 50)
      end,
    })
  end,
}

-- [[
-- Fuzzy finder over `fzf`, `ripgrep`, and others.
-- ]]

return {
  'nvim-telescope/telescope.nvim',
  version = '^0.2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'debugloop/telescope-undo.nvim',
    'aznhe21/actions-preview.nvim',
  },
  cmd = 'Telescope',
  keys = {
    { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Find existing buffers' },
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[s]earch [d]iagnostics' },
    { '<leader>se', '<cmd>Telescope resume<cr>', desc = '[s]earch r[e]sume' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[s]earch [h]elp' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[s]earch [k]eymaps' },
    { '<leader>ss', '<cmd>Telescope builtin<cr>', desc = '[s]earch [s]elect Telescope' },
    { '<leader>st', '<cmd>TodoTelescope<cr>', desc = '[s]earch [t]ODOs' },
    { '<leader>su', '<cmd>Telescope undo<cr>', desc = '[s]earch [u]ndo history' },
    { '<leader>sy', '<cmd>Telescope filetypes<cr>', desc = '[s]earch filet[y]pes' },
    { '<leader>/', function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { previewer = false }) end, desc = 'Fuzzy search in current buffer' },
    { '<leader>s/', function() require('telescope.builtin').live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end, desc = 'Fuzzy search in open file[s]' },
    { '<leader>ca', function() require('actions-preview').code_actions() end, desc = '[c]ode [a]ction' },
    { '<C-t>', function()
      vim.cmd 'enew'
      require('telescope.builtin').find_files {
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            local entry = require('telescope.actions.state').get_selected_entry()
            require('telescope.actions').close(prompt_bufnr)
            vim.cmd('edit ' .. entry.path)
          end)
          return true
        end,
      }
    end, desc = 'Edit in a new buffer' },
  },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        file_ignore_patterns = {
          '.git',
          'node_modules',
          'Packages', -- Roblox Wally
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- [[ Extensions ]]
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'undo')

    local actions_preview = require 'actions-preview'
    actions_preview.setup {
      diff = {
        algorithm = 'patience',
        ignore_whitespace = true,
      },
      telescope = require('telescope.themes').get_dropdown { winblend = 10 },
    }
  end,
}

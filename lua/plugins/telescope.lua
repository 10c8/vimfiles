-- [[
-- Fuzzy finder over `fzf`, `ripgrep`, and others.
-- ]]

return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  event = 'VimEnter',
  branch = '0.1.x',
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
    'nvim-telescope/telescope-frecency.nvim',
    'debugloop/telescope-undo.nvim',
    'aznhe21/actions-preview.nvim',
  },
  config = function()
    local telescope = require 'telescope'
    local ts_builtin = require 'telescope.builtin'

    -- [[ Configuration ]]
    -- see `:help telescope` and `:help telescope.setup()`
    -- local theme = {
    --   theme = 'ivy',
    --   layout_config = { height = 0.4 },
    -- }

    telescope.setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        frecency = {
          auto_validate = false,
          matcher = 'fuzzy',
          path_display = { 'shorten' },
        },
      },
      -- pickers = {
      --   buffers = theme,
      --   file_browser = theme,
      --   find_files = theme,
      --   git_files = theme,
      --   help_pages = theme,
      --   keymaps = theme,
      --   live_grep = theme,
      --   treesitter = theme,
      --   man_pages = {
      --     sections = { '1', '2', '3' },
      --     theme = 'ivy',
      --     layout_config = { height = 0.4 },
      --   },
      -- },
    }

    -- [[ Extensions ]]
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'frecency')
    pcall(telescope.load_extension, 'undo')

    local actions_preview = require 'actions-preview'
    actions_preview.setup {
      diff = {
        algorithm = 'patience',
        ignore_whitespace = true,
      },
      telescope = require('telescope.themes').get_dropdown { winblend = 10 },
    }

    -- [[ Keymaps ]]
    -- see `:help telescope.builtin`
    vim.keymap.set('n', '<leader><leader>', ts_builtin.buffers, { desc = 'Find existing buffers' })
    -- vim.keymap.set('n', '<leader>s.', ts_builtin.oldfiles, { desc = '[s]earch recent files' })
    vim.keymap.set('n', '<leader>sd', ts_builtin.diagnostics, { desc = '[s]earch [d]iagnostics' })
    vim.keymap.set('n', '<leader>se', ts_builtin.resume, { desc = '[s]earch r[e]sume' })
    vim.keymap.set('n', '<leader>sg', ts_builtin.live_grep, { desc = '[s]earch by [g]rep' })
    vim.keymap.set('n', '<leader>sh', ts_builtin.help_tags, { desc = '[s]earch [h]elp' })
    vim.keymap.set('n', '<leader>sk', ts_builtin.keymaps, { desc = '[s]earch [k]eymaps' })
    vim.keymap.set('n', '<leader>sr', '<CMD>Telescope frecency workspace=CWD<CR>', { desc = '[s]earch [r]ecent files' })
    vim.keymap.set('n', '<leader>ss', ts_builtin.builtin, { desc = '[s]earch [s]elect Telescope' })
    vim.keymap.set('n', '<leader>st', '<CMD>TodoTelescope<CR>', { desc = '[s]earch [t]ODOs' })
    vim.keymap.set('n', '<leader>su', '<CMD>Telescope undo<CR>', { desc = '[s]earch [u]ndo history' })
    vim.keymap.set('n', '<leader>sw', ts_builtin.grep_string, { desc = '[s]earch current [w]ord' })
    vim.keymap.set('n', '<leader>sy', ts_builtin.filetypes, { desc = '[s]earch filet[y]pes' })

    vim.keymap.set('n', '<leader>sf', function()
      ts_builtin.find_files { hidden = true }
    end, { desc = '[s]earch [f]iles' })

    vim.keymap.set('n', '<leader>sn', function()
      ts_builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[s]earch co[n]fig files' })

    vim.keymap.set('n', '<leader>/', function()
      ts_builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown { previewer = false }
      )
    end, { desc = 'Fuzzy search in current buffer' })

    -- see `:help telescope.builtin.live_grep()`
    vim.keymap.set('n', '<leader>s/', function()
      ts_builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Fuzzy search in open file[s]' })

    vim.keymap.set('n', '<C-t>', function()
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
    end, { noremap = true, desc = 'Edit in a new buffer' })

    -- actions-preview
    vim.keymap.set('n', '<leader>ca', actions_preview.code_actions, { desc = '[c]ode [a]ction' })
  end,
}

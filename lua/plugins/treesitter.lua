-- [[
-- Syntax highlighting and text objects.
-- ]]

local ensure_installed = {
  'bash',
  'c',
  'html',
  'javascript',
  'lua',
  'markdown',
  'regex',
  'rust',
  'toml',
  'typescript',
  'vimdoc',
}

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = 'BufReadPre',
  build = ':TSUpdate',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-context',
      config = function()
        local context = require 'treesitter-context'

        context.setup {
          max_lines = 6,
          min_window_height = 33,
          mode = 'topline',
          zindex = 10,
        }

        -- [[ Keymaps ]]
        vim.keymap.set('n', '[c', function()
          context.go_to_context(vim.v.count1)
        end, { silent = true, desc = 'Go to previous context' })
      end,
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    -- see `:help nvim-treesitter`
    require('nvim-treesitter.install').compilers = { 'clang' }

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      ensure_installed = ensure_installed,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = {
        enable = false,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
          },
        },
        swap = {
          enable = true,
          swap_next = { ['<leader>>'] = '@parameter.inner' },
          swap_previous = { ['<leader><'] = '@parameter.inner' },
        },
      },
    }
  end,
}

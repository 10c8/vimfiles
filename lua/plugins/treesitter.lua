-- [[
-- Syntax highlighting and text objects.
-- ]]

local ensure_installed = {
  'bash',
  'c',
  'css',
  'html',
  'javascript',
  'lua',
  'markdown',
  'nim',
  'regex',
  'rust',
  'toml',
  'svelte',
  'typescript',
  'vimdoc',
}

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
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
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      config = function()
        require('nvim-treesitter-textobjects').setup {
          select = {
            lookahead = true,
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
            },
          },
        }

        -- Selection Keymaps
        local select = require 'nvim-treesitter-textobjects.select'
        vim.keymap.set({ 'x', 'o' }, 'af', function()
          select.select_textobject('@function.outer', 'textobjects')
        end, { desc = 'Around function' })
        vim.keymap.set({ 'x', 'o' }, 'if', function()
          select.select_textobject('@function.inner', 'textobjects')
        end, { desc = 'Inside function' })
        vim.keymap.set({ 'x', 'o' }, 'ac', function()
          select.select_textobject('@class.outer', 'textobjects')
        end, { desc = 'Around class' })
        vim.keymap.set({ 'x', 'o' }, 'ic', function()
          select.select_textobject('@class.inner', 'textobjects')
        end, { desc = 'Inside class' })

        -- Swap Keymaps
        local swap = require 'nvim-treesitter-textobjects.swap'
        vim.keymap.set('n', '<leader>>', function()
          swap.swap_next '@parameter.inner'
        end, { desc = 'Swap next parameter' })
        vim.keymap.set('n', '<leader><', function()
          swap.swap_previous '@parameter.inner'
        end, { desc = 'Swap previous parameter' })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
  config = function()
    -- Compile with Zig
    require('nvim-treesitter.install').compilers = { 'zig' }

    -- Setup treesitter
    local ts = require 'nvim-treesitter'
    ts.setup()

    -- Install missing parsers on startup
    local installed = require('nvim-treesitter.config').get_installed()

    local to_install = {}
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, lang) then
        table.insert(to_install, lang)
      end
    end

    if #to_install > 0 then
      ts.install(to_install)
    end
  end,
}

-- [[
-- High-performance file picker and grepping tool.
-- ]]

return {
  'dmtrKovalenko/fff.nvim',
  lazy = false,
  build = function()
    require('fff.download').download_or_build_binary()
  end,
  keys = {
    {
      '<leader>sf',
      function()
        require('fff').find_files()
      end,
      desc = '[s]earch [f]iles (fff)',
    },
    {
      '<leader>sg',
      function()
        require('fff').live_grep()
      end,
      desc = '[s]earch by [g]rep (fff)',
    },
    {
      '<leader>sw',
      function()
        require('fff').live_grep { query = vim.fn.expand '<cword>' }
      end,
      desc = '[s]earch current [w]ord (fff)',
    },
    {
      '<leader>sr',
      function()
        require('fff').find_files()
      end,
      desc = '[s]earch [r]ecent files (fff)',
    },
    {
      '<leader>sn',
      function()
        require('fff').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = '[s]earch co[n]fig files (fff)',
    },
  },
  opts = {},
}

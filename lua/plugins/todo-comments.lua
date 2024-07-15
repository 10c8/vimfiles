-- [[
-- Highlights and lists todo, fixme, hack, etc., comments.
-- ]]

return {
  'folke/todo-comments.nvim',
  lazy = true,
  event = 'BufReadPre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('todo-comments').setup {
      keywords = {
        FIX = {
          icon = ' ',
          color = 'error',
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' },
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = '󰈸 ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '󰙨 ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
        SAFETY = { icon = ' ', color = 'hint' },
      },
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*:*]],
      },
      colors = {
        error = { '#fb4934' },
        warning = { '#fe8019' },
        info = { '#83a598' },
        hint = { '#a89984' },
        default = { 'Identifier' },
        test = { 'Identifier' },
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    }

    -- [[ Keymaps ]]
    vim.keymap.set('n', '<leader>TT', '<cmd>TodoTrouble<CR>', { desc = 'Open the [T]odo list' })
  end,
}

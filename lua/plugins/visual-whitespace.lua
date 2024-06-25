-- [[
-- Shows whitespace characters in a selection.
-- ]]

return {
  'mcauley-penney/visual-whitespace.nvim',
  lazy = true,
  event = 'BufRead',
  opts = {
    highlight = { link = 'Comment' },
  },
}

-- [[
-- Preview lines when writing `:##`.
-- ]]

return {
  'nacro90/numb.nvim',
  lazy = true,
  event = 'BufRead',
  opts = {
    show_numbers = true,
    show_cursorline = true,
    hide_relativenumbers = true,
    number_only = false,
    centered_peeking = true,
  },
}

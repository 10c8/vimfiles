-- [[
-- Creates missing directories when writing a file.
-- ]]

return {
  'jghauser/mkdir.nvim',
  lazy = true,
  event = 'BufWritePre',
}

-- [[
-- Overrides the "delete" operation to not yank.
-- ]]

return {
  'gbprod/cutlass.nvim',
  lazy = false, -- Needed to work with `which-key.nvim`
  opts = {
    cut_key = 'm',
  },
}

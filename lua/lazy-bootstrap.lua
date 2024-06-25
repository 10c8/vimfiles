-- Install Lazy
-- see `:help lazy.nvim.txt`
local lazy_path = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazy_path) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    repo,
    lazy_path,
  }
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazy_path)

-- Load plugins
require('lazy').setup {
  { import = 'plugins' },
}

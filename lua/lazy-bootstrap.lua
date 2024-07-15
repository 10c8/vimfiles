-- Install Lazy
-- see `:help lazy.nvim.txt`
local lazy_path = vim.fn.stdpath [[data]] .. '/lazy/lazy.nvim'

---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazy_path) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local err = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    repo,
    lazy_path,
  }

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { err,                            'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazy_path)

-- Load plugins
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  checker = { enabled = true },
}

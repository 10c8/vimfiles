-- [[ Autocommands ]]
local autocmds = {
  ['Highlight yanked text'] = { 'TextYankPost', 'yank-hl', vim.highlight.on_yank },
  ['Set indentation to 2 spaces'] = {
    'Filetype',
    'indent-set',
    function()
      vim.cmd 'setlocal shiftwidth=2 tabstop=2 expandtab'
    end,
    { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'lua' },
  },
  ['Change dir to home conditionally'] = {
    'BufWinEnter',
    'chdir-auto',
    function()
      local neovide_path = vim.fn.expand 'C:\\Program Files\\Neovide'

      if vim.fn.getcwd() == neovide_path then
        vim.cmd 'cd ~'
      end
    end,
  },
}

-- Create autocommands
local augroups = {}
for desc, data in pairs(autocmds) do
  local event, group, callback, pattern = unpack(data)

  local augroup = augroups[group]
  if not augroup then
    augroup = vim.api.nvim_create_augroup(group, { clear = true })
    augroups[group] = augroup
  end

  vim.api.nvim_create_autocmd(event, { desc = desc, group = augroup, callback = callback, pattern = pattern })
end

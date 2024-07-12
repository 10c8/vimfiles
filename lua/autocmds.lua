-- [[ Autocommands ]]
local autocmds = {
  ['Highlight yanked text'] = { 'TextYankPost', 'yank-hl', vim.highlight.on_yank },
  ['Set indentation to 2 spaces'] = {
    'Filetype',
    'indent-set',
    'setlocal shiftwidth=2, tabstop=2',
    { 'html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'lua' },
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

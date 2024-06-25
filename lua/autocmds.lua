-- [[ Autocommands ]]
local autocmds = {
  ['TextYankPost'] = { 'Highlight yanked text', 'yank-hl', vim.highlight.on_yank },
}

-- Create autocommands
local augroups = {}
for event, data in pairs(autocmds) do
  local desc, group, callback = unpack(data)

  local augroup = augroups[group]
  if not augroup then
    augroup = vim.api.nvim_create_augroup(group, { clear = true })
    augroups[group] = augroup
  end

  vim.api.nvim_create_autocmd(event, { desc = desc, group = augroup, callback = callback })
end

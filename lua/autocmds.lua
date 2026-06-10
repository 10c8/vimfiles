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
  ['Automatically show LSP diagnostics on hover'] = {
    'CursorHold',
    'lsp-diag-hover',
    function()
      if #vim.diagnostic.get(0) == 0 then
        return
      end

      local opts = {
        focusable = false,
        close_events = {
          'CursorMoved',
          'CursorMovedI',
          'BufHidden',
          'InsertCharPre',
          'WinLeave',
        },
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }

      pcall(vim.diagnostic.open_float, nil, opts)
    end,
  },
  -- ['Create new change after X seconds'] = {
  --   'CursorHoldI',
  --   'change-new',
  --   function()
  --     -- This makes it so that vim's undo doesn't just get rid of the entirety of what was
  --     -- typed in insert mode, but rather creates a new change every few seconds
  --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-g>u', true, false, true), 'n', false)
  --   end,
  -- }
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

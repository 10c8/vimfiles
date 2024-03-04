return {
  'justinmk/vim-sneak',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    vim.cmd 'let g:sneak#label = 1'

    -- [[ Keymaps ]]
    vim.keymap.set('n', 'f', '<Plug>Sneak_s', { silent = true })
    vim.keymap.set('n', 'F', '<Plug>Sneak_S', { silent = true })
  end,
}

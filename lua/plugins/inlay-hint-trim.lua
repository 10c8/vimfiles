return {
  'ray-d-song/inlay-hint-trim.nvim',
  opts = {
    max_length = 16,
    ellipsis = '…',
    clients = {
      ['gopls'] = true,
      ['lua_ls'] = true,
      ['svelte'] = true,
      ['ts_ls'] = true,
      ['vue_ls'] = true,
    },
  },
}

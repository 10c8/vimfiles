return {
  'ray-d-song/inlay-hint-trim.nvim',
  opts = {
    max_length = 20,
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

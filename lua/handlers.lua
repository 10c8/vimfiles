local inlay_hint_o = vim.lsp.handlers['textDocument/inlayHint']

vim.lsp.handlers['textDocument/inlayHint'] = function(err, result, ctx, config)
  if err and err.message:match 'Cannot call methods on an unopened' then
    return
  end

  return inlay_hint_o(err, result, ctx, config)
end

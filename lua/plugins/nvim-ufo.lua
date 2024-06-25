-- [[
-- Smart folds.
-- ]]

return {
  'kevinhwang91/nvim-ufo',
  lazy = true,
  event = 'VeryLazy',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  config = function()
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local totalLines = vim.api.nvim_buf_line_count(0)
      local foldedLines = endLnum - lnum
      local suffix = ('  %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0

      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)

        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)

          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })

          chunkWidth = vim.fn.strdisplaywidth(chunkText)

          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end

          break
        end

        curWidth = curWidth + chunkWidth
      end

      local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
      -- local rAlignAppndx = math.max(math.min(vim.api.nvim_win_get_width(0), width - 1) - curWidth - sufWidth, 0)
      suffix = (' '):rep(rAlignAppndx) .. suffix

      table.insert(newVirtText, { suffix, 'Comment' })
      return newVirtText
    end

    local ufo = require 'ufo'
    ufo.setup {
      open_fold_hl_timeout = 400,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
      },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
      fold_virt_text_handler = handler,
      provider_selector = function(_, filetype, _)
        if filetype == 'python' then
          return { 'indent' }
        end
      end,
    }

    vim.o.foldcolumn = '0'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- [[ Keymaps ]]
    vim.keymap.set('n', 'zO', ufo.openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zC', ufo.closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end)
  end,
}

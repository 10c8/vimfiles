return {
  'neoclide/coc.nvim',
  lazy = true,
  ft = {
    'vue',
    -- 'clangd',
    'css',
    'scss',
    'less',
    -- 'go',
    'haxe',
    'html',
    -- 'json',
    -- 'markdown',
    -- 'python',
    -- 'rust',
    -- 'lua',
    -- 'toml',
    'javascript',
    'typescript',
    'typescriptreact',
    'javascriptreact',
    -- 'graphql',
    -- 'yaml',
    -- 'zig',
  },
  branch = 'master',
  build = 'npm ci',
  config = function()
    vim.g.coc_global_extensions = {
      -- '@yaegassy/coc-marksman',
      '@yaegassy/coc-tailwindcss3',
      '@yaegassy/coc-volar',
      -- 'coc-clangd',
      'coc-css',
      'coc-git',
      -- 'coc-go',
      'coc-haxe',
      'coc-html',
      -- 'coc-json',
      -- 'coc-markdownlint',
      'coc-prettier',
      -- 'coc-pyright',
      -- 'coc-rust-analyzer',
      -- 'coc-sumneko-lua',
      -- 'coc-toml',
      'coc-tsserver',
      -- 'coc-yaml',
      -- 'coc-zig',
    }

    function _G.check_backspace()
      local col = vim.fn.col '.' - 1
      return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
    end

    local opts = {
      noremap = true,
      expr = true,
      silent = true,
      replace_keycodes = true,
    }

    -- [[ Keymaps ]]
    -- Tab for autocompletion
    vim.keymap.set('i', '<TAB>',
      'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_backspace() ? "<TAB>" : coc#refresh()', opts)
    vim.keymap.set('i', '<S-TAB>', 'coc#pum#visible() ? coc#pum#previous(1) : "<C-h>"', opts)

    -- <CR> accepts completion item or notifies CoC to format
    vim.keymap.set('i', '<CR>', [[coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"]],
      opts)

    -- <C-j> to trigger snippets
    vim.keymap.set('i', '<C-j>', '<Plug>(coc-snippets-expand-jump)')

    -- <C-space> to trigger completion
    vim.keymap.set('i', '<C-space>', 'coc#refresh()', { silent = true, expr = true })

    -- `[g` and `]g` to navigate diagnostics
    vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
    vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

    -- Code navigation
    -- vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true, desc = '[g]oto [d]efinition' })
    vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true, desc = '[g]oto [y]pe definition' })
    vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true, desc = '[g]oto [i]mplementation' })
    vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true, desc = '[g]oto [r]eferences' })

    -- Shift K to show documentation in preview window
    vim.keymap.set('n', 'K', function()
      local cw = vim.fn.expand '<cword>'
      if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
      elseif vim.api.nvim_eval 'coc#rpc#ready()' then
        vim.fn.CocActionAsync 'doHover'
      else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
      end
    end, { silent = true })

    vim.keymap.set('n', '<leader>k', '<Plug>(coc-float-jump)', { silent = true, desc = 'Jump inside float' })

    -- Symbol renaming
    vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true, desc = '[r]ename symbol' })

    -- Format selected code
    vim.keymap.set('x', '<leader>f', '<Plug>(coc-format-selected)', { silent = true, desc = '[f]ormat selected' })
    vim.keymap.set('n', '<leader>f', '<Plug>(coc-format-selected)', { silent = true, desc = '[f]ormat selected' })

    -- Apply code action to the selected region
    vim.keymap.set('x', '<leader>a', '<Plug>(coc-codeaction-selected)',
      { silent = true, nowait = true, desc = 'Apply code [a]ction (selected)' })
    vim.keymap.set('n', '<leader>a', '<Plug>(coc-codeaction-selected)',
      { silent = true, nowait = true, desc = 'Apply code [a]ction (selected)' })

    vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)',
      { silent = true, nowait = true, desc = 'Apply code [a]ction ([c]ursor)' })
    vim.keymap.set('n', '<leader>as', '<Plug>(coc-codeaction-source)',
      { silent = true, nowait = true, desc = 'Apply code [a]ction ([s]ource)' })

    -- Apply the most preferred quickfix action on the current line
    vim.keymap.set(
      'n',
      '<leader>qf',
      '<Plug>(coc-fix-current)',
      { silent = true, nowait = true, desc = 'Apply [q]uick[f]ix action on current line' }
    )

    -- Refactoring
    vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true, desc = '[re]factor' })
    vim.keymap.set('n', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)',
      { silent = true, desc = '[r]efactor selected' })
    vim.keymap.set('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)',
      { silent = true, desc = '[r]efactor selected' })

    -- Code Lens actions
    vim.keymap.set('n', '<leader>cl', '<Plug>(coc-codelens-action)',
      { silent = true, nowait = true, desc = 'Run [c]ode [l]ens actions on current line' })

    -- Map function and class text objects
    vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)', { silent = true, nowait = true })
    vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)', { silent = true, nowait = true })
    vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)', { silent = true, nowait = true })
    vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)', { silent = true, nowait = true })
    vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)', { silent = true, nowait = true })
    vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)', { silent = true, nowait = true })
    vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)', { silent = true, nowait = true })
    vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)', { silent = true, nowait = true })

    -- <C-j> and <C-k> to scroll on floating windows
    vim.keymap.set('n', '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"',
      { silent = true, nowait = true, expr = true })
    vim.keymap.set('n', '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"',
      { silent = true, nowait = true, expr = true })

    vim.keymap.set('i', '<C-j>', 'coc#float#has_scroll() ? "<C-j>=coc#float#scroll(1)<CR>" : "<Right>"',
      { silent = true, nowait = true, expr = true })
    vim.keymap.set('i', '<C-k>', 'coc#float#has_scroll() ? "<C-k>=coc#float#scroll(0)<CR>" : "<Right>"',
      { silent = true, nowait = true, expr = true })

    vim.keymap.set('v', '<C-j>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"',
      { silent = true, nowait = true, expr = true })
    vim.keymap.set('v', '<C-k>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"',
      { silent = true, nowait = true, expr = true })

    -- <C-j> and <C-k> to scroll suggestions
    vim.keymap.set('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"',
      { silent = true, nowait = true, expr = true })
    vim.keymap.set('i', '<C-k>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"',
      { silent = true, nowait = true, expr = true })

    -- CoCList
    vim.keymap.set('n', '<leader>ld', '<CMD>CocList diagnostics<CR>',
      { silent = true, nowait = true, desc = 'Show all [d]iagnostics' })
    vim.keymap.set('n', '<leader>le', '<CMD>CocList extensions<CR>',
      { silent = true, nowait = true, desc = 'Manage [e]xtensions' })
    vim.keymap.set('n', '<leader>lc', '<CMD>CocList commands<CR>',
      { silent = true, nowait = true, desc = 'Show [c]ommands' })
    vim.keymap.set('n', '<leader>lo', '<CMD>CocList outline<CR>',
      { silent = true, nowait = true, desc = 'Show [o]utline' })
    vim.keymap.set('n', '<leader>ls', '<CMD>CocList -I symbols<CR>',
      { silent = true, nowait = true, desc = 'Search workspace [s]ymbols' })
    vim.keymap.set('n', '<leader>lj', '<CMD>CocNext<CR>',
      { silent = true, nowait = true, desc = 'Do default action for next item' })
    vim.keymap.set('n', '<leader>lk', '<CMD>CocPrev<CR>',
      { silent = true, nowait = true, desc = 'Do default action for previous item' })
    vim.keymap.set('n', '<leader>lp', '<CMD>CocListResume<CR>',
      { silent = true, nowait = true, desc = 'Resume latest CoC list' })

    -- [[ Autocommands ]]
    vim.api.nvim_create_augroup('CoCGroup', {})

    -- Highlight symbol and references on hover
    vim.api.nvim_create_autocmd('CursorHold', {
      group = 'CoCGroup',
      command = 'silent call CocActionAsync("highlight")',
      desc = 'Highlight symbol under cursor on hover',
    })

    -- Update signature help on jump placeholder
    vim.api.nvim_create_autocmd('User', {
      group = 'CoCGroup',
      pattern = 'CocJumpPlaceholder',
      command = 'call CocActionAsync("showSignatureHelp")',
      desc = 'Update signature help on jump placeholder',
    })

    -- [[ Commands ]]
    vim.api.nvim_create_user_command('Format', 'call CocAction("format")', {})
    vim.api.nvim_create_user_command('Organize', 'call CocActionAsync("runCommand", "editor.action.organizeImport")', {})
  end,
}

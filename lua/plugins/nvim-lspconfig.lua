-- [[
-- Configs for the Neovim LSP client.
-- ]]

local must_install = {
  'cssls',
  'emmet_language_server',
  'gopls',
  'html',
  'lua_ls',
  'marksman',
  -- 'nim_langserver',
  'svelte',
  'tailwindcss',
  'taplo',
  'ts_ls',
  'volar',
  'wgsl_analyzer',
  -- 'xmlformatter',
}

local ft = {
  'css', -- cssls
  'html', -- emmet_language_server
  'handlebars',
  'javascriptreact',
  'typescriptreact',
  'vue',
  'lua', -- lua_ls
  'markdown', -- marksman
  -- 'nim', -- nim_langserver
  -- 'python',
  'toml', -- taplo
  'javascript', -- tsserver
  'svelte',
  'typescript',
  'vue', -- volar
  'wgsl', -- wgsl_analyzer
  'xml', -- xmlformatter
}

return {
  'neovim/nvim-lspconfig',
  lazy = true,
  ft = ft,
  dependencies = {
    {
      'williamboman/mason.nvim',
      run = ':MasonUpdate',
      opts = {
        PATH = 'prepend',
      },
    },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
    'hrsh7th/nvim-cmp',
  },
  opts = {
    inlay_hints = { enabled = true },
    servers = must_install,
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local telescope = require 'telescope.builtin'

        local map = function(keys, func, desc)
          if keys == '<leader>ca' then
            return
          end

          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- [[ Keymaps ]]
        -- Jump to the definition of the word under your cursor.
        map('gdd', telescope.lsp_definitions, '[g]oto [d]efinition')

        -- Find references for the word under your cursor.
        map('gr', telescope.lsp_references, '[g]oto [r]eferences')

        -- Jump to the implementation of the word under your cursor.
        map('gI', telescope.lsp_implementations, '[g]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        map('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        map('<leader>ds', telescope.lsp_document_symbols, '[d]ocument [s]ymbols')

        -- Fuzzy find all the symbols in your current workspace
        map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

        -- Rename the variable under your cursor
        map('<F2>', vim.lsp.buf.rename, 'Rename symbol')

        -- List code actions.
        -- map('<leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction')

        -- Open documentation popup.
        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        -- Go to the declaration of the word under your cursor.
        map('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

        -- [[ Autocommands ]]
        -- Highlight the word under your cursor
        -- see `:help CursorHold`
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Inlay hints
        -- FIXME: This generates errors on Vue for some reason
        -- if client and client.server_capabilities.inlayHintProvider then
        --   vim.lsp.inlay_hint.enable(true)
        -- end
      end,
    })

    -- see `:help lsp.protocol.make_client_capabilities`
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Enable folding with `kevinhwang91/nvim-ufo`
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- LSP servers
    -- see `:help lspconfig-all`
    local servers = {
      cssls = {
        filetypes = { 'css' },
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
        },
      },
      tailwindcss = {
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                { "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*).*?[\"'`]" }
              },
            },
          },
        },
      },
      nim_langserver = {
        nimsuggestPath = vim.fn.exepath 'nimsuggest',
      },
    }

    -- see `:Mason`
    require('mason-lspconfig').setup {
      automatic_installation = true,
      ensure_installed = opts.servers,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

          -- TypeScript
          if server_name == 'ts_ls' then
            local mason_registry = require 'mason-registry'
            local vls_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

            -- Enable Volar if we're opening a Vue file
            -- if vim.bo.filetype == 'vue' then
            server.init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = vls_path,
                  languages = { 'vue' },
                },
              },
            }
            -- end

            server.filetypes = {
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'vue',
            }
          end

          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}

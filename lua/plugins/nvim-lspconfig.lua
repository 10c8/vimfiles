-- [[
-- Configs for the Neovim LSP client.
-- ]]

local must_install = {
  'biome',
  'clangd',
  'cssls',
  'emmet_language_server',
  'gopls',
  'html',
  'lua_ls',
  'marksman',
  'stylua',
  'svelte',
  'tailwindcss',
  'taplo',
  'ts_ls',
  'vue_ls',
  'vtsls',
  'wgsl_analyzer',
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    { 'mason-org/mason-lspconfig.nvim', opts = {} },
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Status updates
    { 'j-hui/fidget.nvim', opts = {} },

    -- Completion
    'saghen/blink.cmp',
  },
  config = function()
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
        if client and client:supports_method('textDocument/documentHighlight', event.buf) then
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
        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
      end,
    })

    -- Enable folding with `kevinhwang91/nvim-ufo`
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- LSP servers
    -- see `:help lspconfig-all`
    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vim.fn.stdpath 'data' .. '\\mason\\packages\\vue-language-server\\node_modules\\@vue\\language-server',
      languages = { 'vue' },
      configNamespace = 'typescript',
    }

    local servers = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
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
                { '(["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]' },
              },
            },
          },
        },
      },
      vtsls = {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },
        filetypes = {
          -- 'javascript',
          -- 'javascriptreact',
          -- 'typescript',
          -- 'typescriptreact',
          'vue',
        },
      },
      ts_ls = {
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'none',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      svelte = {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'none' },
            },
          },
        },
        plugin = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'none' }, -- "none" | "literals" | "all"
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionParameterTypes = { enabled = false },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
        },
      },
    }

    -- Install servers
    require('mason-tool-installer').setup {
      ensure_installed = must_install,
      auto_update = true,
    }

    -- Configure and enable each server
    for server, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})

      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}

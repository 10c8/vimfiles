-- [[
-- Auto-completions using blink.cmp
-- ]]

return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'onsails/lspkind-nvim',
    'xzbdmw/colorful-menu.nvim',
  },
  version = '*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'hide' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-p>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 700,
      },
      ghost_text = {
        enabled = false,
        show_with_menu = false,
      },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', gap = 1 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                if ctx.source_name ~= 'Path' then
                  return (require('lspkind').symbol_map[ctx.kind] or '') .. ctx.icon_gap
                end

                local is_unknown_type = vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'block', 'unknown' }, ctx.item.data.type)
                local mini_icon, _ = require('mini.icons').get(is_unknown_type and 'os' or ctx.item.data.type, is_unknown_type and '' or ctx.label)

                return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
              end,

              highlight = function(ctx)
                if ctx.source_name ~= 'Path' then
                  return ctx.kind_hl
                end

                local is_unknown_type = vim.tbl_contains({ 'link', 'socket', 'fifo', 'char', 'block', 'unknown' }, ctx.item.data.type)
                local mini_icon, mini_hl = require('mini.icons').get(is_unknown_type and 'os' or ctx.item.data.type, is_unknown_type and '' or ctx.label)
                return mini_icon ~= nil and mini_hl or ctx.kind_hl
              end,
            },
            label = {
              text = function(ctx)
                return require('colorful-menu').blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require('colorful-menu').blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },

    fuzzy = {
      implementation = 'rust',
      sorts = {
        function(a, b)
          if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
            return
          end

          -- Lower priority for Emmet
          return b.client_name == 'emmet_ls'
        end,
        'exact',
        'score',
        'sort_text',
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}

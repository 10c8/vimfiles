-- [[
-- Statusline.
-- ]]

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'AndreM222/copilot-lualine',
  },
  config = function()
    local function trunc(tw, tl, hw, no_ellipsis)
      return function(str)
        local ww = vim.fn.winwidth(0)

        if hw and ww < hw then
          return ''
        elseif tw and tl and ww < tl and #str > tl then
          return str:sub(1, tl) .. (no_ellipsis and '' or '...')
        end

        return str
      end
    end

    require('lualine').setup {
      options = {
        theme = 'gruvbox-material',
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(mode)
              local mode_map = {
                ['NORMAL'] = 'N',
                ['VISUAL'] = 'V',
                ['V-LINE'] = 'L',
                ['V-BLOCK'] = 'B',
                ['INSERT'] = 'I',
                ['COMMAND'] = 'C',
                ['TERMINAL'] = 'T',
                ['REPLACE'] = 'R',
                ['SELECT'] = 'S',
                ['S-LINE'] = 'L',
                ['S-BLOCk'] = 'B',
                ['EX'] = 'X',
                ['PROMPT'] = 'P',
                ['SHELL'] = '$',
                ['LUA'] = '!',
              }

              return mode_map[mode] or mode
            end,
          },
        },
        lualine_b = {
          'branch',
          {
            -- Gitsigns
            'diff',
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            'diagnostics',
            sources = { 'nvim_lsp' },
            symbols = {
              error = ' ',
              warn = ' ',
              hint = ' ',
              info = ' ',
            },
          },
        },
        lualine_c = {},
        lualine_x = {
          { 'encoding', fmt = trunc(nil, nil, 81, true) },
          {
            'fileformat',
            icons_enabled = true,
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
            fmt = trunc(nil, nil, 81, true),
          },
          'filetype',
          'copilot', -- Copilot status
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}

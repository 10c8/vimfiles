return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = 'hard'
    vim.g.gruvbox_material_foreground = 'original'
    vim.g.gruvbox_material_statusline_style = 'original'

    vim.g.gruvbox_material_diagnostic_line_highlight = 1
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_float_style = 'dim'

    vim.g.gruvbox_material_better_performance = 1

    vim.cmd [[
      let g:gruvbox_material_colors_override = {
        \ "aqua": ["#b8bb26", "142"],
        \ "green": ["#8ec07c", "108"]
      \ }
    ]]

    vim.cmd.colorscheme 'gruvbox-material'
  end,
}

return {
  'zbirenbaum/neodim',
  event = 'LspAttach',
  config = function()
    require('neodim').setup {
      alpha = 0.7,
      blend_color = '#1d2021',
      hide = {
        signs = false,
        virtual_text = false,
        underline = false,
      },
      refresh_delay = 75,
      regex = {
        '[uU]nused',
        '[nN]ever [uU]sed',
        '[nN]ever [rR]ead',
        '[nN]ot [rR]ead',
      },
    }
  end,
}

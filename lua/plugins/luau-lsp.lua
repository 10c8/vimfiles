return {
  'lopi-py/luau-lsp.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local function is_rojo_project(path)
      return vim.fs.root(path, function(name)
        return name:match '.+%.project%.json$'
      end)
    end

    require('luau-lsp').setup {
      platform = {
        type = is_rojo_project(0) and 'roblox' or 'standard',
      },
      sourcemap = {
        enabled = true,
        autogenerate = true,
        rojo_project_file = 'default.project.json',
        sourcemap_file = 'sourcemap.json',
      },
      types = {
        roblox_security_level = 'PluginSecurity',
      },
      fflags = {
        enable_new_solver = true,
        sync = true,
        override = {
          LuauTypeSolverRelease = "647",
          LuauSolverV2 = "true",
          LuauUserDefinedTypeFunctionsSyntax2 = "true",
          LuauUserDefinedTypeFunction2 = "true"
        },
      },
      plugin = {
        enabled = true,
        port = 3667,
      },
      settings = {
        ['luau-lsp'] = {
          completion = {
            imports = {
              enabled = true,
            },
          },
        },
      },
      server = {
        cmd = { 'luau-lsp', 'lsp' },
        root_dir = is_rojo_project,
      },
    }
  end,
}

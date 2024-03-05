return {
  'puremourning/vimspector',
  init = function()
    vim.g.vimspector_enable_mappings = 'HUMAN'
  end,
  config = function()
    -- [[ Keymaps ]]
    -- Close the vimspector window
    vim.keymap.set('n', '<leader>vc', '<cmd>call vimspector#Reset()<cr>', { noremap = true, desc = '[c]lose the [v]imspector window' })

    -- Create `.vimspector.json` file for Rust
    vim.keymap.set('n', '<leader>vlr', function()
      -- Find `cargo.toml` file to find the root of the project
      local root = vim.fn.getcwd()
      while root ~= '/' do
        if vim.fn.filereadable(root .. '/Cargo.toml') == 1 then
          break
        end
        root = vim.fn.fnamemodify(root, ':h')
      end

      -- Get the binary name from the `Cargo.toml` file
      local cargo_toml = vim.fn.readfile(root .. '/Cargo.toml')
      local binary_name = 'main'

      for _, line in ipairs(cargo_toml) do
        if vim.fn.match(line, 'name') ~= -1 then
          binary_name = vim.fn.matchstr(line, '"[^"]*"')
          binary_name = vim.fn.substitute(binary_name, '"', '', 'g')
          break
        end
      end

      -- Create the `.vimspector.json` file
      local file = root .. '/.vimspector.json'
      if vim.fn.filereadable(file) == 0 then
        vim.fn.writefile({
          '{',
          '  "configurations": {',
          '    "Launch": {',
          '      "adapter": "CodeLLDB",',
          '      "configuration": {',
          '        "type": "lldb",',
          '        "request": "launch",',
          '        "program": "${workspaceRoot}/target/debug/${' .. binary_name .. '}",',
          '        "args": [],',
          '        "cwd": "${workspaceRoot}",',
          '        "sourceLanguages": ["rust"]',
          '      },',
          '      "breakpoints": {',
          '        "exception": {',
          '          "cpp_throw": "Y",',
          '          "cpp_catch": "N"',
          '        }',
          '      }',
          '    }',
          '  }',
          '}',
        }, file)
      end
    end, { noremap = true, desc = 'Create `.[v]imspector.json` file for [r]ust' })
  end,
}

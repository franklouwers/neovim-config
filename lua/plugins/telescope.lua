-- file searching / live greppin' / ...
return {
  { -- use telescope picker for select items in neovim
    "nvim-telescope/telescope-ui-select.nvim",
  },
  { -- telescope core
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("telescope").setup({
        extensions = {
          ['ui-select'] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })

      require("telescope").load_extension("ui-select")
    end
  },
  'jvgrootveld/telescope-zoxide',
  config = function()
    local t = require("telescope")
    local z_utils = require("telescope._extensions.zoxide.utils")

    -- Configure the extension
    t.setup({
      extensions = {
        zoxide = {
          prompt_title = "[ Walking on the shoulders of TJ ]",
          mappings = {
            default = {
              after_action = function(selection)
                print("Update to (" .. selection.z_score .. ") " .. selection.path)
              end
            },
            ["<C-s>"] = {
              before_action = function(selection) print("before C-s") end,
              action = function(selection)
                vim.cmd.edit(selection.path)
              end
            },
            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
          },
        },
      },
    })

    -- Load the extension
    t.load_extension('zoxide')
  end
}

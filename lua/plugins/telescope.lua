-- file searching / live greppin' / ...
return {
  { -- use telescope picker for select items in neovim
    "nvim-telescope/telescope-ui-select.nvim",
  },

  { -- telescope core
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim', 'debugloop/telescope-undo.nvim', },
    config = function()
      local opts = {
        extensions = {
          undo = {
            mappings = {
              i = {
                ["<s-cr>"] = require("telescope-undo.actions").yank_additions,
                ["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<cr>"] = require("telescope-undo.actions").restore
              },
            },
          },
          ['ui-select'] = {
            require("telescope.themes").get_dropdown { }
          }
        }
      }

      require("telescope").setup(opts)

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("undo")
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
            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
          },
        },
      },
    })

    -- Load the extension
    t.load_extension('zoxide')
  end
}

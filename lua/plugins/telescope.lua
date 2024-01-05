-- file searching / live greppin' / ...
return {
  { -- use telescope picker for select items in neovim
        "nvim-telescope/telescope-ui-select.nvim",
  },
  { -- telescope core
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
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
  }
}

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        dim_inactive = {
          enabled = true,
        },
        integrations = {
          navic = {
            enabled = true,
          },
        },
      })
      vim.cmd.colorscheme "catppuccin-macchiato"
    end,
  },
  -- {
  --   "marko-cerovac/material.nvim",
  --   lazy = false,
  --   name = "material",
  --   priority = 1000,
  --   config = function()
  --     require("material").setup({
  --       plugins = {
  --         "gitsigns",
  --         "mini",
  --         "neogit",
  --         "neo-tree",
  --         "nvim-cmp",
  --         "nvim-navic",
  --         "nvim-web-devicons",
  --         "telescope",
  --         "trouble",
  --         "which-key",
  --         "nvim-notify",
  --       },
  --     })
  --     vim.cmd.colorscheme "material-darker"
  --   end,
  -- },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = { smooth = false },
    event = { "WinNew" },
  },
}

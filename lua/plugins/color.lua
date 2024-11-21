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
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = { smooth = false },
    event = { "WinNew" },
  },
}

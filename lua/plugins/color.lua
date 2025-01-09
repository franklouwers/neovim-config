return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        overrides = function(colors)
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end
      })
      vim.cmd.colorscheme "kanagawa"
    end
  },

  -- better window separators
  {
    "nvim-zh/colorful-winsep.nvim",
    opts = { smooth = false },
    event = { "WinNew" },
  },
}

return {
  -- add zen-mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- configure neo-tree
  {
    "neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          show_hidden = true,
          respect_gitignore = true,
        },
      },
    },
  },
}

return {
  {
    'nvim-mini/mini.animate', version = '*'
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      bottom = {
        -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        {
          ft = "lazyterm",
          title = "LazyTerm",
          size = { height = 0.4 },
          filter = function(buf)
            return not vim.b[buf].lazyterm_cmd
          end,
        },
        { ft = "qf",            title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
        { ft = "claude",        size = { height = 0.4 } },
      },
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Files",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem" and vim.b[buf].neo_tree_position ~= "float"
          end,
          size = { height = 0.1 },
        },
        {
          title = "Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers" and vim.b[buf].neo_tree_position ~= "float"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        -- any other neo-tree windows
        "neo-tree",
      },
    },
  },

  -- provides lsp updates in lower right corner
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        override_vim_notify = true,
      }
    },
  }
}

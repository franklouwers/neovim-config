return {
  -- extends `%` support to language specific stuff, using treesitter
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      require 'nvim-treesitter.configs'.setup {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          disable = {},  -- optional, list of language that will be disabled
          -- [options]
        },
      }
    end
  },
  -- expand surround support. (eg change 'word' to [word] etc)
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- underline current word
  {
    'nvim-mini/mini.cursorword',
    version = '*',
    config = function()
      require('mini.cursorword').setup()
    end
  }

}

return {
  -- extends `%` support to language specific stuff, using treesitter
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
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
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  -- underline current word
  {
    'nvim-mini/mini.cursorword',
    version = '*',
    event = "BufReadPost",
    opts = {},
  },
}

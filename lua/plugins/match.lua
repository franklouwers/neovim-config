return {
  -- extends `%` support to language-specific matches
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      -- Keep matchup independent from external Tree-sitter parser plugins.
      vim.g.matchup_treesitter_enabled = false
    end,
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

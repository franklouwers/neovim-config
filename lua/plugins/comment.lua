-- gc to comment visual region
-- gcc to comment current line (Nomral mode)
return {
  {
    'numToStr/Comment.nvim',
    opts = {
      -- ignores empty lines - vscode compatibility
      ignore = '^$'
    },
    lazy = false
  },
}

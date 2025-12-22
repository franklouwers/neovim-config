return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  opts = { options = { 
    theme = 'auto',
    disabled_filetypes = {
      statusline = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles' },
      winbar = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles' },
    }
  } },
}

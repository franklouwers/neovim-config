return {   -- which key should I use?
  'folke/which-key.nvim',
  event = "VeryLazy",
  config = function()
    require('which-key').setup(
      { plugins = { spelling = true } }
    )
  end,
}

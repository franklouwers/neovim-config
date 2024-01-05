-- parse files, provide syntax HL etc
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "javascript", "ruby", "python", "terraform" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}

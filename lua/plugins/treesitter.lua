-- parse files, provide syntax HL etc
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "lua", "javascript", "ruby", "python", "terraform" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}

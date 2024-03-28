return {

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      --    "ibhagwan/fzf-lua",              -- optional
    },
    cmd = 'Neogit',
    config = true,
    opt = {
      use_per_project_settings = false
    }
  },

 { -- gitsigns: git interactionas and indicate changes in sidebar
   "lewis6991/gitsigns.nvim",
   config = function()
     require('gitsigns').setup() -- batteries included
   end

 }
}

return {

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      --    "ibhagwan/fzf-lua",              -- optional
    },
    cmd = 'Neogit',
    config = true,
    opt = {
      use_per_project_settings = false,
      graph_style = 'unicode',
      git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        ["gitlab.com"] =
        "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        ["gitlab.x-plose.be"] =
        "https://gitlab.x-plose.be/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
      },

    }
  },

  { -- gitsigns: git interactionas and indicate changes in sidebar
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup() -- batteries included
    end

  }
}

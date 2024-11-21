-- file tree
return
{
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = 'Neotree',

  -- load when we're opening on a dir
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
      callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd('Neotree current dir=' .. f)
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
        end
      end
    })
  end,

  opts = {
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },

    filesystem = {
      hijack_netrw_behavior = 'open_current',
      filtered_items = {
        visible = true, -- visible, but different
        hide_dotfiles = false,
        hide_by_name = {
          ".git"
        }
      },
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = true
      }
    }
  }
}

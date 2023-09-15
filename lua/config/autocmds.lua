-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

-- try to restore sanity when quitting
vim.api.nvim_create_autocmd("QuitPre", {
  pattern = "*",
  command = "bdelete",
  group = vim.api.nvim_create_augroup("DeleteBufferOnQuit", { clear = true }),
  desc = "Delete buffer when quitting",
})

-- Disable built-in spellchecking for Markdown
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- vim.api.nvim_create_autocmd("FileType", {
--   group = vim.api.nvim_create_augroup("lazyvim_user_markdown", { clear = true }),
--   pattern = { "gitcommit", "markdown" },
--   callback = function()
--     vim.opt_local.wrap = true
--   end,
-- })

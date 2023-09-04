-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Don't want no save on C-s! What is this? Word?
for _, mode in pairs({ "i", "v", "n" }) do
  vim.keymap.del(mode, "<C-s>")
end

-- use F4 for floating term. <c-/> seems to be intercepted somehow
local Util = require("lazyvim.util")
vim.keymap.del("n", "<c-/>")
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end

vim.keymap.set("n", "<F4>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("t", "<F4>", "<cmd>close<cr>", { desc = "Hide Terminal" })

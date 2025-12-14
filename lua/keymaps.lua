-- space leader
vim.g.mapleader = ' '

-- quickly hide search result with ESC
vim.keymap.set('n', '<ESC>', ':nohlsearch<CR>:echo<CR>')

-- For git
vim.keymap.set("n", "<leader>GG", "<cmd>Neogit<CR>")

-- Trigger Neo-Tree filetree:
vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem reveal left<CR>')

-- Telescope
vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files() end, { desc = "Find files" })
vim.keymap.set('n', '<leader>fg', function() require("telescope.builtin").live_grep() end, { desc = "Grep in files" })
vim.keymap.set('n', '<leader>fb', function() require("telescope.builtin").buffers() end, { desc = "Show buffers" })
vim.keymap.set('n', '<leader>fq', function() require("telescope.builtin").diagnostics() end, { desc = "Show diagnostics" })
vim.keymap.set("n", "<leader>cd", function() require("telescope").extensions.zoxide.list() end)

-- Undo tree
vim.keymap.set('n', '<F5>', "<cmd>Telescope undo<cr>")

-- Diagnostics navigation
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

-- cp to copy to system clipboard
vim.keymap.set({ 'n', "v" }, 'cp', '"+y')

-- keep visual mode when indenting
vim.keymap.set('v', ">", "> gv")
vim.keymap.set('v', "<", "< gv")
vim.keymap.set('v', "=", "= gv")

-- Plugin keybindings (see :help <plugin> for details):
-- gc/gcc: comment, K/gd/gr/F2-F4: LSP, <C-t>: terminal
-- ys/ds/cs: surround (e.g. ysiw) → :help surround

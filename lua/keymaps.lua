-- space leader
vim.g.mapleader = ' '

-- quickly hide search result with ESC
vim.keymap.set('n', '<ESC>', ':nohlsearch<CR>:echo<CR>')

-- For git
vim.keymap.set("n", "<leader>GG", "<cmd>Neogit<CR>")

-- Structural S&R
vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)

-- Trigger Neo-Tree filetree:
vim.keymap.set('n', '<C-n>', '<cmd>Neotree filesystem reveal left<CR>')
-- vim.keymap.set('n', '<C-n>', function() vim.cmd.Neotree() require("edgy").open('left') end)
vim.keymap.set('n', '<leader>n', '<cmd>Neotree buffers reveal float<CR>')

-- Telescope
vim.keymap.set('n', '<C-f>', function() require("telescope.builtin").find_files() end)
vim.keymap.set('n', '<leader>fg', function() require("telescope.builtin").live_grep() end)
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set("n", "<leader>cd", function() require("telescope").extensions.zoxide.list() end)

-- Undo Telescope
vim.keymap.set('n', '<F5>', "<cmd>Telescope undo<cr>")

-- Undo Telescope
vim.keymap.set('n', '<F6>', "<cmd>Navbuddy<cr>")

-- Troublelist
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)

-- cp to copy to system clipboard
vim.keymap.set({ 'n', "v" }, 'cp', '"+y')

-- in visual mode, use option-\ («) to comment
vim.keymap.set('x', "«", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")
-- normal mode is defined in comment.lua. Don't ask

-- keep visual mode when indenting
vim.keymap.set('v', ">", "> gv")
vim.keymap.set('v', "<", "< gv")
vim.keymap.set('v', "=", "= gv")

-- Defined by plugins:

-- Comments:
-- gc to comment visual region
-- gcc to comment current line (Nomral mode)

-- cmp:
-- when in completion:
--   <C-space>: complete
--   <C-u>: up
--   <C-d>: down
--   <C-f>: jump forward
--   <C-b>: jump backward
--   <C-y>: confirm selection
--   <C-e>: cancel completion
-- <C-p>: trigger completion menu

-- lsp:
-- K: info about symbol under cursor
-- gd: jump to definition of symbol
-- gD: jump to Declaration of the symbol
-- gi: list the implementation details
-- go: jump to definition of the type
-- gs: display signature information
-- <F2>: renames all refs
-- <F3>: format code in current buffer
-- <F4>: selection an action available

-- ToggleTerm:
-- <C-\> Toggle Term

-- Surround:
-- The three "core" operations of add/delete/change can be done with the keymaps:
--   add:    ys{motion}{char},
--   delete: ds{char},
--   change: cs{target}{replacement}
--
--   For the following examples, * will denote the cursor position:

--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
--

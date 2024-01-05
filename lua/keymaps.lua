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
vim.keymap.set('n', '<leader>n', '<cmd>Neotree buffers reveal float<CR>')

-- Telescope
vim.keymap.set('n', '<C-f>', function() require("telescope.builtin").find_files() end)
vim.keymap.set('n', '<leader>fg', function() require("telescope.builtin").live_grep() end)
      -- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Undo Tree
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)


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

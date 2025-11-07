-- spaces, not tabs, 2 spaces for indenting (if you need more for visibility, you need more sleep)
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- round tabs
vim.o.shiftround = true

-- numbers
vim.wo.number = true

-- dd from empty lines go to the blackhole, so a p won't paste
-- them!
-- While strictly speaking a keymap, I feel it's more a config option, so I'll keep it here...
vim.keymap.set("n", "dd", function()
  if vim.fn.getline(".") == "" then return '"_dd' end
  return "dd"
end, { expr = true })

-- full file path
vim.o.title = true
vim.o.titlelen = 0
vim.o.titlestring = '%{expand(\"%:p\")}'

-- indent line wraps when initial line had indentation
vim.o.breakindent = true

-- search: case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Undofile support
vim.o.undofile = true

-- Cursorline
vim.o.cursorline = true

-- highlight the yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- On neogit event, update neotree git status
local group = vim.api.nvim_create_augroup('MyCustomNeogitEvents', { clear = true })
vim.api.nvim_create_autocmd('User', {
  pattern = 'NeogitStatusRefreshed',
  group = group,
  callback = function()
    require("neo-tree.sources.manager").refresh("filesystem")
  end
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- tf files are always terraform, not "tf" (whatever that is)
-- vim.filetype.add({
--   extension = {
--     tf = 'terraform'
--   }
-- })

-- format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

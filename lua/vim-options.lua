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

-- tf files are always terraform, not "tf" (whatever that is)
vim.filetype.add({
  extension = {
    tf = 'terraform'
  }
})

-- format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

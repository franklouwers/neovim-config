return {
  'akinsho/toggleterm.nvim',
  version = "*",
  cmd = "ToggleTerm",
  keys = { { "<C-t>", desc = "Toggle terminal" } },
  opts = {
    open_mapping = [[<C-t>]],
    direction = 'horizontal',
    size = 30,
    on_open = function()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end,
  },
}

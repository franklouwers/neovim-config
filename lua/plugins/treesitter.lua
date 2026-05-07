-- Core Tree-sitter highlighting for parsers bundled with Neovim.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("CoreTreesitter", { clear = true }),
  pattern = { "c", "lua", "markdown", "query", "vim", "vimdoc", "help" },
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and pcall(vim.treesitter.language.add, lang) then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})

return {}

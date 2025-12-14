-- Native LSP configuration (Neovim 0.11+)

-- Reserve signcolumn space to avoid layout shift
vim.o.signcolumn = 'yes'

-- Keymaps on LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, opts)
  end,
})

-- Enable language servers
-- Servers are configured via lsp/<name>.lua files or use defaults
local servers = {
  'lua_ls',
  'gopls',
  'ruby_lsp',
  'pylsp',
  'terraformls',
  'marksman',
  'ansiblels',
  'helm_ls',
  'gh_actions_ls',
}

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

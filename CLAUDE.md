# CLAUDE.md - Neovim Configuration

## Overview
Lua-based Neovim 0.11+ configuration using Lazy.nvim for plugin management and native `vim.lsp` for language servers.

## File Structure
```
~/.config/nvim/
├── init.lua              # Entry point
├── lua/
│   ├── vim-options.lua   # Vim options
│   ├── keymaps.lua       # Key mappings
│   ├── lsp.lua           # LSP keymaps + server list
│   └── plugins/          # Plugin configurations
├── lsp/                  # Custom LSP server configs
│   └── tofu_ls.lua       # OpenTofu (not in nvim-lspconfig)
├── lazy-lock.json        # Plugin version lock
└── stylua.toml           # Lua formatter (2 spaces, 80 cols)
```

## LSP Setup
- **Native vim.lsp**: Uses `vim.lsp.config()` and `vim.lsp.enable()` (Neovim 0.11+)
- **nvim-lspconfig**: Provides server configurations
- **Completion**: blink.cmp

### Enabled Servers
```
lua_ls, gopls, ruby_lsp, pylsp, ts_ls, vue_ls,
tofu_ls, marksman, ansiblels, helm_ls, gh_actions_ls
```

### LSP Keybindings
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `go` | Go to type definition |
| `gr` | Find references |
| `gs` | Signature help |
| `F2` | Rename symbol |
| `F3` | Format code |
| `F4` | Code actions |

## Adding a New LSP
1. If in nvim-lspconfig: add server name to `lua/lsp.lua` servers list
2. If custom: create `lsp/<name>.lua` with `cmd`, `filetypes`, `root_markers`

## Adding Plugins
1. Create file in `lua/plugins/`
2. Use `opts` over `config` when possible
3. Use lazy loading (`event`, `cmd`, `keys`, `ft`)

## Commands
```bash
stylua .                    # Format Lua
:Lazy sync                  # Sync plugins to lockfile
:Lazy update                # Update plugins + lockfile
:checkhealth vim.lsp        # Check LSP status
```
# CLAUDE.md - Neovim Configuration Assistant

## Overview
This is a speed-optimized, Lua-based Neovim configuration using Lazy.nvim for plugin management.

## Key Configuration Details

### Plugin Manager
- Uses **Lazy.nvim** for plugin loading
- Plugins are organized in `lua/plugins/` directory
- Each plugin has its own file for modularity

### Language Support & Tools
- **LSP**: Mason + nvim-lspconfig for language servers
- **Completion**: blink.cmp (fast, modern completion engine)
- **Formatting**: StyLua configured (2 spaces, 80 columns)
- **Languages**: Lua, Ruby, Go, Python, Terraform, Ansible, Markdown, Bash/Zsh

### Installed LSPs & Tools
```
ansiblels, jinja_lsp, helm_ls, marksman, lua_ls, luacheck, 
ruby_lsp, standardrb, terraformls, tflint, gopls, golangci-lint, 
goimports, python-lsp-server, beautysh, editorconfig-checker, 
semgrep, trivy
```

### Key Bindings (LSP)
- `K` - Hover documentation
- `gd` - Go to definition
- `gD` - Go to declaration  
- `gi` - Go to implementation
- `go` - Go to type definition
- `gr` - Find references
- `gs` - Signature help
- `F2` - Rename symbol
- `F3` - Format code
- `F4` - Code actions

## Development Commands

### Linting & Formatting
```bash
# Lua formatting
stylua .

# Language-specific linting (available via LSP)
# Go: golangci-lint run
# Ruby: standardrb
# Terraform: tflint
# Python: python-lsp-server diagnostics
```

### Testing
```bash
# No specific test framework configured
# Add project-specific test commands here
```

## File Structure
```
~/.config/nvim/
├── init.lua              # Main config entry
├── lua/
│   ├── vim-options.lua   # Vim options
│   ├── keymaps.lua       # Key mappings
│   └── plugins/          # Plugin configurations
│       ├── lsp.lua       # LSP + completion setup
│       ├── telescope.lua # Fuzzy finder
│       ├── treesitter.lua# Syntax highlighting
│       └── ...
└── stylua.toml          # Lua formatter config
```

## Performance Notes
- Lazy loading enabled for most plugins
- Minimal startup time prioritized
- No heavy frameworks loaded by default
- LSP servers loaded on-demand per filetype

## Adding New Plugins
1. Create new file in `lua/plugins/`
2. Follow existing plugin structure
3. Use lazy loading when possible
4. Keep performance in mind - avoid heavy dependencies
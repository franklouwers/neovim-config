-- LSPs, Linters, etc
-- See lsp-zero.nvim as a starting point. It can autoconfigure a lot

return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },

  -- Autocompletion
  {
    'saghen/blink.cmp',
    dependencies = {
      { "saghen/blink.compat", version = "*", lazy = true, opts = {} },
      'rafamadriz/friendly-snippets',
      "hrsh7th/cmp-emoji",
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'super-tab' },

      signature = { enabled = true },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      completion = {
        -- auto show docs
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
    },
    opts_extend = { "sources.default" },
  },


  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      { 'saghen/blink.cmp' },
      { 'williamboman/mason-lspconfig.nvim' },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          { "SmiteshP/nvim-navic", config = function() require("nvim-navic").setup { highlight = true } end },
          { "MunifTanjim/nui.nvim" },
        },
      },
    },

    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {}

      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      navbuddy.setup {
        lsp = { auto_attach = true },
        mappings = {
          ["<left>"] = actions.parent(),    -- Move to left panel
          ["<right>"] = actions.children(), -- Move to right panel
        },
        custom_hl_group = "Visual",
      }


      require("mason-lspconfig").setup({
        ensure_installed = {

          --- LUA
          "lua_ls", -- lua lsp

          -- RUBY
          "ruby_lsp",   -- ruby lsp
          "standardrb", -- ruby linting and style

          -- TERRAFORM
          "terraformls", -- terraform lsp
          "tflint",      -- terraform linting

          -- GOLANG
          "gopls", -- golang lsp

        },

        handlers = {
          lsp_zero.default_setup,
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })
    end
  },


  -- K: info about symbol under cursor
  -- gd: jump to definition of symbol
  -- gD: jump to Declaration of the symbol
  -- gi: list the implementation details
  -- go: jump to definition of the type
  -- gs: display signature information
  -- <F2>: renames all refs
  -- <F3>: format code in current buffer
  -- <F4>: selection an action available
  -- ---
  -- Completion:
  -- <C-y>: confirm selection
  -- <C-e>: cancel completion
  -- <C-p>: trigger completion menu
  { -- install Mason packages (other than pure LSPs, which are defined above
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require('mason-tool-installer').setup({
        ensure_installed = {

          -- RUBY
          "erb-lint", -- ruby ERB linting
          "rubyfmt",  -- ruby formatter

          -- LUA
          'luacheck', -- lua linter

          -- GOLANG
          'golangci-lint', -- Golang lint
          'goimports',     -- Golang fmt
          'gopls',         -- Go language server

          -- ZSH / BASH
          "beautysh", -- bash beautifier


          -- PYTHON
          "python-lsp-server",

          -- TERRAFORM
          "terraformls",


          -- GENERAL
          'editorconfig-checker',
          "semgrep",  -- static analysis to detect bugs. go, json, js, php, python, ruby, ...
          "trivy",    -- security scans, misconfigs in multiple languages (including go, docker, helm, ruby, terraform, ...
          "marksman", -- markdown
        },

        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = true,


        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      })
    end

  }
}

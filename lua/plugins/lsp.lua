-- LSPs, Linters, autocompletion, ...
return {
  -- easy install LSPs
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
      -- 'rafamadriz/friendly-snippets',
    },

    -- use a release tag to download pre-built binaries
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'super-tab' },

      signature = { enabled = false },

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
        default = { 'lazydev', 'lsp', 'path', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- make priority
          },
        },
      },
      completion = {
        -- menu = {
        --   border = 'shadow'
        -- },
        -- auto show docs
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          -- window = {
          --   border = 'rounded'
          -- },
        },
        ghost_text = {
          enabled = true
        },

        trigger = {
          show_in_snippet = false
        },
      },
    },
    opts_extend = { "sources.default" },
  },


  -- LSP config
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },

    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,

    config = function()
      -- if not installed, add a few default Language Servers via Mason
      require("mason-lspconfig").setup({
        automatic_installation = false, -- mason-installer does this
        ensure_installed = {},

        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          -- this is the custom handler for 'example client'
          -- example_server = function ...
        },
      })

      --      require('lspconfig').gh_actions_ls.setup({}) -- not via mason yet

      -- This is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require('mason-tool-installer').setup {

        -- a list of all tools you want to ensure are installed upon
        -- start
        ensure_installed = {
          -- ANSIBLE
          "ansiblels",
          "jinja_lsp",

          -- HELM
          "helm_ls",

          -- MARKDOWN
          "marksman",

          --- LUA
          "lua_ls",   -- lua lsp
          "luacheck", -- lua linter

          -- RUBY
          "ruby_lsp",   -- ruby lsp
          "standardrb", -- ruby linting and style

          -- TERRAFORM
          "terraformls", -- terraform lsp
          "tflint",      -- terraform linting

          -- GOLANG
          "gopls",         -- golang lsp
          'golangci-lint', -- Golang lint
          'goimports',     -- Golang fmt

          -- PYTHON
          "python-lsp-server",

          -- ZSH / BASH
          "beautysh", -- bash beautifier

          -- GENERAL
          'editorconfig-checker',
          "semgrep", -- static analysis to detect bugs. go, json, js, php, python, ruby, ...
          "trivy",   -- security scans, misconfigs in multiple languages (including go, docker, helm, ruby, terraform, ...

        },
        auto_update = true,
        debounce_hours = 5, -- at least 5 hours between attempts to install/update
      }
    end
  },
  -- adjust lua ls for lua-vim config
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "~/.config/nvim",
        "lazy.vim",
      }
    }
  },



  -- K: info about symbol under cursor
  -- gd: jump to definition of symbol
  -- gD: jump to Declaration of the symbol
  -- gi: list the implementation details
  -- go: jump to definition of the type
  -- gr: jump to references
  -- gs: display signature information
  -- <F2>: renames all refs
  -- <F3>: format code in current buffer
  -- <F4>: selection an action available
}

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
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'onsails/lspkind.nvim' }
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      local lspkind = require('lspkind')

      cmp.setup({
        -- formatting = lsp_zero.cmp_format(),
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          })
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
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
          "semgrep", -- static analysis to detect bugs. go, json, js, php, python, ruby, ...
          "trivy",   -- security scans, misconfigs in multiple languages (including go, docker, helm, ruby, terraform, ...
          "marsman", -- markdown
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

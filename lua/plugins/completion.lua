-- Autocompletion
return {
  {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- allow plugins to extend sources
  opts_extend = { "sources.default" },

    -- event = "InsertEnter",
    -- dependencies = {
    --   { "saghen/blink.compat", version = "*", lazy = true, opts = {} },
    -- },
    -- version = '*',
    opts = {
      keymap = { preset = 'super-tab' },
      signature = { enabled = true },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = true },
        trigger = { show_in_snippet = true },
        menu = {
          draw = {
            columns = {
              { 'label', 'label_description', gap = 2 },
              { 'kind_icon', 'kind', gap = 2 },
            },
            treesitter = { 'lsp' },
          },
        },
      },
       fuzzy = { implementation = "prefer_rust_with_warning" },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- Make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 1000,
          },
          lsp = {
            min_keyword_length = 2,
            score_offset = 500
          },
          path = {
            min_keyword_length = 0,
          },
          snippets = {
            min_keyword_length = 3,
          },
          buffer = {
            min_keyword_length = 4,
            max_items = 5,
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ''
                end, vim.api.nvim_list_bufs())
              end,
            },
          },

        },
      },
    },
  },

  -- Lua API completion for nvim config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "~/.config/nvim",
        "lazy.nvim",
      }
    }
  },
}

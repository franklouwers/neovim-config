-- Autocompletion
return {
  {
    'saghen/blink.cmp',
    event = "InsertEnter",
    dependencies = {
      { "saghen/blink.compat", version = "*", lazy = true, opts = {} },
    },
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'super-tab' },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'lazydev', 'path', 'buffer' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = false },
        trigger = { show_in_snippet = true },
      },
    },
    opts_extend = { "sources.default" },
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

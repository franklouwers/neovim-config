-- depends on toggleterm
-- config "inspired by" (stolen from) https://github.com/coder/claudecode.nvim/issues/96#issuecomment-3138720924

local function smart_toggle(term)
  if term:is_open() then
    if term:is_focused() then
      term:close()
    else
      term:focus()
    end
  else
    term:open()
  end
end

local toggle_key = "<C-t>"

local function setup_toggleterm_provider()
  local claude_terminal = {}

  local toggleterm_provider = {
    setup = function(config)
      local Terminal = require("toggleterm.terminal").Terminal
      claude_terminal = Terminal:new({
        direction = "vertical",
        size = 80,
        on_open = function(t)
          vim.keymap.set({ "n", "t" }, toggle_key, function()
            t:toggle()
          end, { noremap = true, silent = true, buffer = t.bufnr })
        end,
      })
    end,

    open = function(cmd_string, env_table, effective_config, focus)
      claude_terminal.cmd = cmd_string
      claude_terminal.env = env_table
      claude_terminal:open()
    end,

    close = function()
      claude_terminal:close()
    end,

    simple_toggle = function(cmd_string, env_table, effective_config)
      claude_terminal.cmd = cmd_string
      claude_terminal.env = env_table
      claude_terminal:toggle()
    end,

    focus_toggle = function(cmd_string, env_table, effective_config)
      claude_terminal.cmd = cmd_string
      claude_terminal.env = env_table
      smart_toggle(claude_terminal)
    end,

    get_active_bufnr = function()
      if claude_terminal.bufnr then
        return claude_terminal.bufnr
      end
      return nil
    end,

    is_available = function()
      local ok, _ = pcall(require, "toggleterm")
      return ok
    end,
  }

  return toggleterm_provider
end


return {
  "coder/claudecode.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = true,
  opts = {
    -- Send/Focus Behavior
    -- When true, successful sends will focus the Claude terminal if already connected
    focus_after_send = false,
    -- Terminal Configuration
    terminal = {
      split_side = "right",                   -- "left" or "right"
      split_width_percentage = 0.30,
      provider = setup_toggleterm_provider(), -- "auto", "snacks", "native", "external", "none", or custom provider table
      auto_close = true,
      --      snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
    }
  },
  event = "VeryLazy",
  keys = {
    { "<leader>a",  nil,                              desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",              desc = "Send to Claude" },
    {
      "<leader>as",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree" },
    },
    -- Diff management
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}

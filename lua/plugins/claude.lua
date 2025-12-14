local function toggleterm_provider()
  local terminal = nil

  return {
    is_available = function()
      return pcall(require, "toggleterm")
    end,

    setup = function()
      local Terminal = require("toggleterm.terminal").Terminal
      terminal = Terminal:new({ direction = "horizontal", size = 30 })
    end,

    open = function(cmd, env)
      terminal.cmd = cmd
      terminal.env = env
      terminal:open()
    end,

    close = function()
      if terminal then terminal:close() end
    end,

    simple_toggle = function(cmd, env)
      terminal.cmd = cmd
      terminal.env = env
      terminal:toggle()
    end,

    focus_toggle = function(cmd, env)
      terminal.cmd = cmd
      terminal.env = env
      if terminal:is_open() then
        if terminal:is_focused() then terminal:close() else terminal:focus() end
      else
        terminal:open()
      end
    end,

    get_active_bufnr = function()
      return terminal and terminal.bufnr
    end,
  }
end

return {
  "coder/claudecode.nvim",
  dependencies = { "akinsho/toggleterm.nvim" },
  event = "VeryLazy",
  opts = {
    terminal = {
      provider = toggleterm_provider(),
      auto_close = true,
    }
  },
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
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}

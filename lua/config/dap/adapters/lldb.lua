-- ██╗     ██╗     ██████╗ ██████╗ 
-- ██║     ██║     ██╔══██╗██╔══██╗
-- ██║     ██║     ██║  ██║██████╔╝
-- ██║     ██║     ██║  ██║██╔══██╗
-- ███████╗███████╗██████╔╝██████╔╝
-- ╚══════╝╚══════╝╚═════╝ ╚═════╝ 

-- ═══════════════════════════════════════════════════════════
-- ░ LLDB DEBUGGER ADAPTER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

local M = {}

-- ╭─ ADAPTER CONFIGURATION ────────────────────────────────╮
M.adapter = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.expand "$HOME" .. "/.local/share/nvim/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
  name = "lldb",
}

-- ╭─ DEBUG CONFIGURATION ──────────────────────────────────╮
M.config = {
  {
    name = "Launch file",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = function()
      local argument_string = vim.fn.input "Program arguments: "
      return vim.fn.split(argument_string, " ", true)
    end,
  },
}

return M

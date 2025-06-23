-- ███╗   ███╗ █████╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
-- ████╗ ████║██╔══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
-- ██╔████╔██║███████║██████╔╝██████╔╝██║██╔██╗ ██║██║  ███╗███████╗
-- ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔═══╝ ██║██║╚██╗██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║  ██║██║     ██║     ██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝     ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

local wk = require "which-key"
local map = vim.keymap.set
local icons = ICONS

-- ═══════════════════════════════════════════════════════════
-- ░ WHICH-KEY GROUPS
-- ═══════════════════════════════════════════════════════════
wk.add {
  { "<leader>c", group = icons.ui.code .. " Code/LSP", mode = { "n", "v" } },
  { "<leader>d", group = icons.ui.debug .. " Debug" },
  { "<leader>f", group = icons.ui.search .. " Find/Search" },
  { "<leader>g", group = icons.git.icon .. " Git", mode = { "n", "v" } },
  { "<leader>p", group = icons.ui.save .. " Sessions" },
  { "<leader>r", group = icons.ui.replace .. " Refactor" },
  { "<leader>s", group = icons.ui.window .. " Splits" },
  { "<leader>t", group = icons.ui.terminal .. " Terminal" },
  { "<leader>w", group = icons.ui.buffer .. " Buffer" },
  { "<leader>a", group = icons.ui.comment .. " Actions" },
}

-- ═══════════════════════════════════════════════════════════
-- ░ BASIC EDITOR MAPPINGS
-- ═══════════════════════════════════════════════════════════

-- ╭─ INSERT MODE ──────────────────────────────────────────╮
map("i", "jk", "<ESC>", { desc = "Exit insert mode", silent = true })

-- ╭─ NAVIGATION ───────────────────────────────────────────╮
map("n", "H", "^", { desc = "Go to start of line", silent = true })
map("n", "L", "g_", { desc = "Go to end of line", silent = true })

-- ╭─ WINDOW NAVIGATION ────────────────────────────────────╮
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window", silent = true })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window", silent = true })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window", silent = true })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window", silent = true })

-- ╭─ BUFFER NAVIGATION ────────────────────────────────────╮
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = icons.ui.caretRight .. " Next buffer", silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = icons.ui.caretLeft .. " Previous buffer", silent = true })

-- ╭─ EDITING IMPROVEMENTS ─────────────────────────────────╮
-- Don't yank on visual paste
map("v", "p", '"_dP', { desc = "Paste without yanking", silent = true })

-- Don't yank on delete char
map("n", "x", '"_x', { desc = "Delete char without yanking", silent = true })
map("n", "X", '"_X', { desc = "Delete char backward without yanking", silent = true })
map("v", "x", '"_x', { desc = "Delete selection without yanking", silent = true })
map("v", "X", '"_X', { desc = "Delete selection backward without yanking", silent = true })

-- Move selected lines up/down
map("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move selection up", silent = true })
map("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move selection down", silent = true })

-- ╭─ INDENTING ────────────────────────────────────────────╮
map("v", "<", "<gv", { desc = "Indent left", silent = true })
map("v", ">", ">gv", { desc = "Indent right", silent = true })

-- ╭─ SYSTEM INTEGRATION ───────────────────────────────────╮
-- Open links under cursor in browser with gx
if vim.fn.has "macunix" == 1 then
  map("n", "gx", "<cmd>silent execute '!open ' .. shellescape('<cWORD>')<CR>", { desc = "Open link", silent = true })
else
  map("n", "gx", "<cmd>silent execute '!xdg-open ' .. shellescape('<cWORD>')<CR>", { desc = "Open link", silent = true })
end

-- ═══════════════════════════════════════════════════════════
-- ░ LEADER KEY MAPPINGS
-- ═══════════════════════════════════════════════════════════

-- ╭─ BASIC ACTIONS ────────────────────────────────────────╮
map("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = icons.ui.toggle .. " Toggle file explorer", silent = true })
map("n", "<Leader>q", ":q<CR>", { desc = icons.ui.exit .. " Quit buffer", silent = true })
map("n", "<Leader>n", ":set number!<CR>", { desc = icons.ui.toggle .. " Toggle line numbers", silent = true })

-- ╭─ BUFFER MANAGEMENT ────────────────────────────────────╮
map("n", "<Leader>ww", ":w<CR>", { desc = icons.ui.save .. " Save buffer", silent = true })
map("n", "<Leader>wa", ":wa<CR>", { desc = icons.ui.save .. " Save all buffers", silent = true })
map("n", "<Leader>wq", ":wq<CR>", { desc = icons.ui.save .. " Save and quit", silent = true })

-- ╭─ SPLITS ───────────────────────────────────────────────╮
map("n", "<Leader>sh", ":split<CR>", { desc = icons.ui.hsplit .. " Horizontal split", silent = true })
map("n", "<Leader>sv", ":vsplit<CR>", { desc = icons.ui.vsplit .. " Vertical split", silent = true })

-- ═══════════════════════════════════════════════════════════
-- ░ TELESCOPE SEARCH
-- ═══════════════════════════════════════════════════════════
map("n", "<Leader>fh", ":nohlsearch<CR>", { desc = icons.ui.trash .. " Clear search highlight", silent = true })
map("n", "<Leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = icons.ui.search .. " Find files", silent = true })
map("n", "<Leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = icons.ui.search .. " Search text", silent = true })
map("n", "<Leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = icons.ui.buffer .. " Find buffers", silent = true })
map("n", "<Leader>fe", function()
  require("telescope.builtin").help_tags()
end, { desc = icons.ui.lightbulb .. " Find help tags", silent = true })
map("n", "<Leader>fr", function()
  require("telescope.builtin").oldfiles()
end, { desc = icons.ui.history .. " Find recent files", silent = true })
map("n", "<Leader>fc", function()
  require("telescope.builtin").git_commits()
end, { desc = icons.git.icon .. " Find Git commits", silent = true })

-- ═══════════════════════════════════════════════════════════
-- ░ CODE & LSP
-- ═══════════════════════════════════════════════════════════

-- ╭─ LSP NAVIGATION ───────────────────────────────────────╮
map("n", "gd", function()
  vim.lsp.buf.definition()
end, { desc = "Go to definition", silent = true })
map("n", "gr", function()
  vim.lsp.buf.references { includeDeclaration = false }
end, { desc = "Show references", silent = true })
map("n", "gy", function()
  vim.lsp.buf.type_definition()
end, { desc = "Go to type definition", silent = true })

-- ╭─ LSP ACTIONS ──────────────────────────────────────────╮
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = icons.ui.lightbulb .. " Code action", silent = true })
map("v", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = icons.ui.lightbulb .. " Code action", silent = true })

-- ╭─ DIAGNOSTICS ──────────────────────────────────────────╮
map("n", "<leader>cl", function()
  vim.diagnostic.open_float { border = "rounded", max_width = 100 }
end, { desc = icons.diagnostics.error .. " Show diagnostics", silent = true })
map("n", "gl", function()
  vim.diagnostic.open_float { border = "rounded", max_width = 100 }
end, { desc = icons.diagnostics.error .. " Show diagnostics", silent = true })

-- ╭─ REFACTORING ──────────────────────────────────────────╮
map("n", "<Leader>rr", ":%s//g<Left><Left>", { desc = icons.ui.replace .. " Replace in file", silent = false })
map("n", "<Leader>rp", function()
  require("spectre").open_visual { select_word = true }
end, { desc = icons.ui.replace .. " Refactor (Spectre)" })
map("v", "<Leader>rp", function()
  require("spectre").open_visual()
end, { desc = icons.ui.replace .. " Refactor (Spectre)" })

-- ╭─ COMMENTS ─────────────────────────────────────────────╮
map("n", "<C-i>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = icons.ui.comment .. " Toggle comment" })
map("v", "<C-i>", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = icons.ui.comment .. " Toggle comment" })
map("n", "<leader>ac", function()
  require("comment-box").llbox()
end, { desc = icons.ui.comment .. " Comment box" })
map("v", "<leader>ac", function()
  require("comment-box").llbox()
end, { desc = icons.ui.comment .. " Comment box" })

-- ╭─ TODO COMMENTS ────────────────────────────────────────╮
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- ╭─ TREESITTER ───────────────────────────────────────────╮
map("n", "gnn", function()
  require("nvim-treesitter.incremental_selection").init_selection()
end, { desc = "Init treesitter selection" })
map("n", "grn", function()
  require("nvim-treesitter.incremental_selection").node_incremental()
end, { desc = "Increment treesitter node" })
map("n", "grm", function()
  require("nvim-treesitter.incremental_selection").node_decremental()
end, { desc = "Decrement treesitter node" })
map("n", "grc", function()
  require("nvim-treesitter.incremental_selection").scope_incremental()
end, { desc = "Increment treesitter scope" })

-- ╭─ FOLDING ──────────────────────────────────────────────╮
map("n", "zR", function()
  require("ufo").openAllFolds()
end, { desc = "Open all folds", silent = true })
map("n", "zM", function()
  require("ufo").closeAllFolds()
end, { desc = "Close all folds", silent = true })
map("n", "zr", function()
  require("ufo").openFoldsExceptKinds()
end, { desc = "Open folds (except some)", silent = true })

-- ═══════════════════════════════════════════════════════════
-- ░ TERMINAL
-- ═══════════════════════════════════════════════════════════

-- ╭─ TERMINAL MODES ───────────────────────────────────────╮
map("n", "<Leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = icons.ui.terminal .. " Floating terminal", silent = true })
map("n", "<Leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = icons.ui.hsplit .. " Horizontal terminal", silent = true })
map("n", "<Leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = icons.ui.vsplit .. " Vertical terminal", silent = true })

-- ╭─ TERMINAL ESCAPE ──────────────────────────────────────╮
map("t", "jk", "<C-\\><C-n>", { desc = icons.ui.exit .. " Exit terminal mode", silent = true })

-- ╭─ TERMINAL NAVIGATION ──────────────────────────────────╮
_G.set_terminal_keymaps = function()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

-- ═══════════════════════════════════════════════════════════
-- ░ DEBUGGING
-- ═══════════════════════════════════════════════════════════
map("n", "<Leader>dd", function()
  require("dapui").toggle()
end, { desc = icons.ui.debug .. " Toggle debugger UI", silent = true })
map("n", "<Leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = icons.ui.debug .. " Toggle breakpoint", silent = true })
map("n", "<Leader>dc", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = icons.ui.debug .. " Conditional breakpoint", silent = true })
map("n", "<Leader>d<space>", function()
  require("dap").continue()
end, { desc = icons.ui.debug .. " Continue", silent = true })
map("n", "<Leader>dl", function()
  require("dap").step_into()
end, { desc = icons.ui.debug .. " Step into", silent = true })
map("n", "<Leader>dj", function()
  require("dap").step_over()
end, { desc = icons.ui.debug .. " Step over", silent = true })
map("n", "<Leader>dk", function()
  require("dap").step_out()
end, { desc = icons.ui.debug .. " Step out", silent = true })
map("n", "<Leader>de", function()
  require("dap").terminate()
end, { desc = icons.ui.debug .. " Terminate", silent = true })
map("n", "<Leader>dr", function()
  require("dap").run_last()
end, { desc = icons.ui.debug .. " Run last", silent = true })

-- ═══════════════════════════════════════════════════════════
-- ░ GIT
-- ═══════════════════════════════════════════════════════════
map("n", "<Leader>gd", "<cmd>lua ToggleDiffviewFileHistory()<CR>", {
  desc = icons.git.icon .. " File history",
  silent = true,
})
map("n", "<Leader>gS", "<cmd>lua ToggleDiffviewStatus()<CR>", {
  desc = icons.git.icon .. " Git status",
  silent = true,
})
-- ═══════════════════════════════════════════════════════════
-- ░ SESSIONS
-- ═══════════════════════════════════════════════════════════
map("n", "<leader>psl", function()
  vim.cmd "SessionManager load_session"
end, { desc = icons.ui.save .. " Load session" })
map("n", "<leader>psL", function()
  vim.cmd "SessionManager load_last_session"
end, { desc = icons.ui.save .. " Load last session" })
map("n", "<leader>pss", function()
  vim.cmd "SessionManager save_current_session"
end, { desc = icons.ui.save .. " Save session" })
map("n", "<leader>psm", function()
  vim.cmd "SessionManager available_commands"
end, { desc = icons.ui.save .. " Session commands" })

-- ═══════════════════════════════════════════════════════════
-- ░ UPDATES
-- ═══════════════════════════════════════════════════════════
map("n", "<leader>uc", function()
  require("core.utils.updater").force_check()
end, { desc = icons.ui.forbidden .. " Check for updates" })
map("n", "<leader>uu", function()
  require("core.utils.updater").update_config()
end, { desc = icons.ui.forbidden .. " Update vxVim core" })

-- ═══════════════════════════════════════════════════════════
-- ░ EXPERIMENTAL / DISABLED
-- ═══════════════════════════════════════════════════════════
-- map("n", "<Leader>ch", ":ClangdSwitchSourceHeader<CR>", { desc = icons.cpp .. " Switch header/source", silent = true })

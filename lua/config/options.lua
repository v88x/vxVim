--  ██████╗ ██████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗
-- ██╔═══██╗██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝
-- ██║   ██║██████╔╝   ██║   ██║██║   ██║██╔██╗ ██║███████╗
-- ██║   ██║██╔═══╝    ██║   ██║██║   ██║██║╚██╗██║╚════██║
-- ╚██████╔╝██║        ██║   ██║╚██████╔╝██║ ╚████║███████║
--  ╚═════╝ ╚═╝        ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ NEOVIM OPTIONS CONFIGURATION
-- ═══════════════════════════════════════════════════════════

local icons = ICONS

local options = {
  -- ╭─ DISPLAY & UI ─────────────────────────────────────────╮
  number = true,                    -- ░ Enable line numbering
  relativenumber = false,           -- ░ Disable relative line numbers  
  cursorline = true,                -- ░ Highlight current line
  showmode = false,                 -- ░ Don't show -- INSERT --
  laststatus = 3,                   -- ░ Global statusline
  showtabline = 2,                  -- ░ Always show tabs
  signcolumn = "yes:2",             -- ░ Add sign column next to line number
  fillchars = "eob: ",              -- ░ Set characters for empty buffers
  conceallevel = 2,                 -- ░ Conceal text but show custom replacement character
  concealcursor = "",               -- ░ Expand text on cursor line

  -- ╭─ COLORS & THEMES ──────────────────────────────────────╮
  syntax = "on",                    -- ░ Enable syntax highlighting
  termguicolors = true,             -- ░ Enable support for 24-bit colors
  background = "dark",              -- ░ Dark background
  emoji = false,                    -- ░ Fix emoji display

  -- ╭─ INDENTATION & TABS ───────────────────────────────────╮
  expandtab = true,                 -- ░ Use spaces instead of tabs
  shiftwidth = 2,                   -- ░ Number of spaces for one level of indentation
  tabstop = 2,                      -- ░ One tab equals 2 spaces
  softtabstop = 2,                  -- ░ Insert 2 spaces for tab
  smartindent = true,               -- ░ Enable smart indentation
  smarttab = true,                  -- ░ Smart tab settings
  autoindent = true,                -- ░ Enable auto-indent
  listchars = { tab = "→ ", trail = "·" },

  -- ╭─ SEARCH & NAVIGATION ──────────────────────────────────╮
  ignorecase = true,                -- ░ Ignore case in search if all characters are lowercase
  smartcase = true,                 -- ░ Case-sensitive if uppercase letters are used
  incsearch = true,                 -- ░ Incremental search
  hlsearch = true,                  -- ░ Highlight search results
  scrolloff = 8,                    -- ░ Number of lines to keep visible around the cursor
  sidescrolloff = 8,                -- ░ Number of columns to keep visible around the cursor horizontally
  showmatch = true,                 -- ░ Highlight matching parentheses

  -- ╭─ SPLITS & WINDOWS ─────────────────────────────────────╮
  splitbelow = true,                -- ░ Open new horizontal splits below
  splitright = true,                -- ░ Open new vertical splits to the right

  -- ╭─ CLIPBOARD & EDITING ──────────────────────────────────╮
  clipboard = "unnamedplus",        -- ░ Use the system clipboard
  virtualedit = "onemore",          -- ░ Allow the cursor to be placed after the end of the line
  fixeol = false,                   -- ░ Do not add a new line at the end of the file
  joinspaces = false,               -- ░ Prevent joining multiple spaces in search
  backspace = "indent,eol,start",   -- ░ Ensure backspace works as expected
  wrap = false,                     -- ░ No line wrap

  -- ╭─ FOLDING ──────────────────────────────────────────────╮
  foldcolumn = "0",                 -- ░ Fold column display settings
  foldnestmax = 0,                  -- ░ Disable nested folding
  foldlevel = 99,                   -- ░ For ufo provider, large value needed
  foldlevelstart = 99,              -- ░ Expand all folds by default

  -- ╭─ FILES & BACKUP ───────────────────────────────────────╮
  backup = false,                   -- ░ Disable creating backup files
  writebackup = false,              -- ░ Disable write backup
  swapfile = false,                 -- ░ Disable swap files
  undofile = true,                  -- ░ Enable support for undo files
  encoding = "utf-8",               -- ░ File encoding
  fileencoding = "utf-8",           -- ░ Encoding for files

  -- ╭─ PERFORMANCE & TIMING ─────────────────────────────────╮
  updatetime = 100,                 -- ░ Faster completion
  timeoutlen = 200,                 -- ░ Timeout length for key sequences  
  lazyredraw = false,               -- ░ Redraw the screen while executing macros

  -- ╭─ COMPLETION & POPUP ───────────────────────────────────╮
  completeopt = "menu,menuone,noselect", -- ░ Better autocompletion
  pumheight = 10,                   -- ░ Max items in completion menu
  wildmenu = true,                  -- ░ Enable command-line completion menu

  -- ╭─ MISC SETTINGS ────────────────────────────────────────╮
  mouse = "a",                      -- ░ Enable mouse
  history = 1000,                   -- ░ Set size of command history
  viminfo = "'1000",                -- ░ Increase size of file history
  errorbells = false,               -- ░ Disable error bells
}

-- ═══════════════════════════════════════════════════════════
-- ░ APPLY OPTIONS
-- ═══════════════════════════════════════════════════════════

if vim.bo.modifiable then
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- ═══════════════════════════════════════════════════════════
-- ░ GLOBAL VARIABLES
-- ═══════════════════════════════════════════════════════════

local globals = {
  mapleader = VX.leader,
}

for k, v in pairs(globals) do
  vim.g[k] = v
end

-- ═══════════════════════════════════════════════════════════
-- ░ DIAGNOSTIC ICONS
-- ═══════════════════════════════════════════════════════════

local diagnostic_icons = {
  Error = icons.diagnostics.error,
  Warn = icons.diagnostics.warning,
  Hint = icons.diagnostics.question,
  Info = icons.diagnostics.info,
}

for type, icon in pairs(diagnostic_icons) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

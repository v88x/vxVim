-- ██╗   ██╗██╗  ██╗██████╗  ██████╗
-- ██║   ██║╚██╗██╔╝██╔══██╗██╔════╝
-- ██║   ██║ ╚███╔╝ ██████╔╝██║     
-- ╚██╗ ██╔╝ ██╔██╗ ██╔══██╗██║     
--  ╚████╔╝ ██╔╝ ██╗██║  ██║╚██████╗
--   ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

-- ═══════════════════════════════════════════════════════════
-- ░ GLOBAL CONFIGURATION TABLE
-- ═══════════════════════════════════════════════════════════

VX = {
  -- ╭─ LEADER KEY ───────────────────────────────────────────╮
  leader = " ", -- ░ Options: " ", ",", "<Space>", etc.

  -- ╭─ UI SETTINGS ──────────────────────────────────────────╮
  ui = {
    colorscheme = "catppuccin", -- ░ Options: "catppuccin", "tokyonight", "gruvbox", "nord", etc.
    border = "rounded", -- ░ Options: "rounded", "single", "double", "shadow", "none"
    transparent = true,
  },

  -- ╭─ PLUGIN CONFIGURATION ─────────────────────────────────╮
  plugins = {
    -- ░ Syntax highlighting
    highlight = {
      enable = true, -- ░ Enable treesitter highlighting
      indent = true, -- ░ Enable treesitter indentation
      colors = true, -- ░ Enable color highlighting plugin
      autopairs = true,
    },

    -- ░ File tree
    tree = {
      git_hl = true, -- ░ Highlight git changes in tree
      quit_on_open = false, -- ░ Close tree when opening file
      show_root_path = false, -- ░ Show root folder label
      hide_gitignore = false, -- ░ Hide gitignored files
      width = 32,
      side = "left", -- Options: "left", "right"
      auto_open = false,
      auto_close = false,
      follow_current_file = true,
    },

    -- ░ Code formatting
    formatter = {
      format_on_save = true, -- ░ Auto format on save
      timeout = 1000,
      async = true,
    },

    -- ░ Session management
    session = {
      autoload = false, -- ░ Auto load session on startup
      autosave = true, -- ░ Auto save session
      autosave_only_in_session = true, -- ░ Only autosave when in session
      save_on_exit = true,
      restore_buffers = true,
      restore_cwd = true,
    },

    git = {
      signs = true,
      blame = true,
      blame_delay = 700,
    },
  },


}

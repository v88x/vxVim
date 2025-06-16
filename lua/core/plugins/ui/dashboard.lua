return {
  {
    "nvimdev/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local icons = ICONS
      local v = vim.version()
      local version = VERSION
      local plugins = require("lazy").stats().count
      local footer_string = string.format("%s v%d.%d.%d %s %d %s %s", icons.vim, v.major, v.minor, v.patch, icons.packages.package, plugins, icons.git.icon, version)

      require("dashboard").setup {
        theme = "doom",
        disable_move = true,
        config = {
          header = {
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "██╗   ██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
            "██║   ██║╚██╗██╔╝██║   ██║██║████╗ ████║",
            "██║   ██║ ╚███╔╝ ██║   ██║██║██╔████╔██║",
            "╚██╗ ██╔╝ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║",
            " ╚████╔╝ ██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "  ╚═══╝  ╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
            "",
          },

          center = {
            {
              icon = icons.ui.search .. " ",
              icon_hl = "group",
              desc = "Find File                                   ",
              desc_hl = "group",
              key = "f",
              key_hl = "Title",
              key_format = " %s",
              action = "Telescope find_files",
            },
            {
              icon = icons.ui.search .. " ",
              icon_hl = "group",
              desc = "Find Word",
              desc_hl = "group",
              key = "w",
              key_hl = "Title",
              key_format = " %s",
              action = "Telescope live_grep",
            },
            {
              icon = icons.ui.fire .. " ",
              icon_hl = "group",
              desc = "Recents",
              desc_hl = "group",
              key = "h",
              key_hl = "Title",
              key_format = " %s",
              action = "Telescope oldfiles hidden=true",
            },
            {
              icon = icons.ui.light .. " ",
              icon_hl = "group",
              desc = "Load Last Session",
              desc_hl = "group",
              key = "l",
              key_hl = "Title",
              key_format = " %s",
              action = "SessionManager load_last_session",
            },
            {
              icon = icons.ui.wrench .. " ",
              icon_hl = "group",
              desc = "Manage Plugins",
              desc_hl = "group",
              key = "p",
              key_hl = "Title",
              key_format = " %s",
              action = "Lazy",
            },
            {
              icon = icons.ui.forbidden .. " ",
              icon_hl = "group",
              desc = "Update vxVim Core",
              desc_hl = "group",
              key = "u",
              key_hl = "Title",
              key_format = " %s",
              action = function()
                require("core.utils.updater").update_config()
              end,
            },
            {
              icon = icons.ui.exit .. " ",
              icon_hl = "group",
              desc = "Exit",
              desc_hl = "group",
              key = "<Esc>",
              key_hl = "Title",
              key_format = " %s",
              action = "exit",
            },
          },
          footer = { footer_string },
        },
      }
    end,
  },
}

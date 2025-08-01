return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      local icons = ICONS
      local lualine = require "lualine"

      local colors = {
        bg = "#11111b",
        fg = "#cdd6f4",
        yellow = "#f9e2af",
        cyan = "#94e2d5",
        darkblue = "#89b4fa",
        green = "#a6e3a1",
        orange = "#fab387",
        violet = "#cba6f7",
        magenta = "#b4befe",
        blue = "#89dceb",
        red = "#f38ba8",
      }
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand "%:t") ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand "%:p:h"
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      local config = {
        options = {
          globalstatus = true,
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end
      ins_left {
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 0, right = 1 },
      }
      ins_left {
        function()
          return "VX"
        end,
        color = function()
          local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
          }
          return { fg = mode_color[vim.fn.mode()], gui = "bold" }
        end,
        padding = { right = 1 },
      }
      ins_left {
        "filesize",
        cond = conditions.buffer_not_empty,
      }
      ins_left {
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.magenta, gui = "bold" },
      }
      ins_left { "location" }
      ins_left { "progress", color = { fg = colors.fg, gui = "bold" } }
      ins_left {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = icons.diagnostics.error .. " ", warn = icons.diagnostics.warning .. " ", info = icons.diagnostics.info .. " " },
        diagnostics_color = {
          error = { fg = colors.red },
          warn = { fg = colors.yellow },
          info = { fg = colors.cyan },
        },
      }
      ins_left {
        function()
          return "%="
        end,
      }
      ins_left {
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = icons.ui.cogs .. " LSP:",
        color = { fg = "#ffffff", gui = "bold" },
      }
      ins_right {
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = colors.green, gui = "bold" },
      }
      ins_right {
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
      }
      ins_right {
        "branch",
        icon = "",
        color = { fg = colors.violet, gui = "bold" },
      }
      ins_right {
        "diff",
        symbols = { added = icons.git.add .. " ", modified = icons.git.unstaged .. " ", removed = icons.git.remove .. " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
        cond = conditions.hide_in_width,
      }
      ins_right {
        function()
          return "▊"
        end,
        color = { fg = colors.blue },
        padding = { left = 1 },
      }

      lualine.setup(config)
    end,
  },
}

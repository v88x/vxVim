return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        ensure_installed = {
          "lua",
          "cpp",
          "python",
          "javascript",
          "typescript",
          "css",
          "tsx",
          "vue",
          "gitcommit",
          "markdown",
          "prisma",
          "json",
          "json5",
          "vim",
          "html",
        },
        highlight = {
          enable = VX.plugins.highlight.enable,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          -- keymaps moved to mappings.lua
        },
        indent = {
          enable = VX.plugins.highlight.indent,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 9999,
        },
      }
    end,
  },
}

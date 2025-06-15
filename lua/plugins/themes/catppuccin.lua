return {
    -- ╭──────────────────────────────────────────────────────────╮
    -- │ catppuccin theme                                         │
    -- │ catppuccin.com                                           │
    -- ╰──────────────────────────────────────────────────────────╯
    {
      "catppuccin/nvim",
      name = "catppuccin",
      config = function()
              require("catppuccin").setup {
        flavor = "mocha",
        transparent_background = VX.ui.transparent,
      }
      vim.cmd("colorscheme " .. VX.ui.colorscheme)
      end,
    },
  }
  
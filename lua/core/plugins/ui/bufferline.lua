return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ nvim-bufferline                                          │
  -- │ tabs like in GUI text editors                            │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "akinsho/nvim-bufferline.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufAdd", "BufReadPost" },
    config = function()
      require("bufferline").setup {
        options = {
          numbers = "none",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
          separator_style = { " ", " " },
          hide_terminal_buffers = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "",
              text_align = "left",
              separator = true,
            },
          },
        },
      }
    end,
  },
}

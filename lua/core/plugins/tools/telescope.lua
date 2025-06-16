return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- event = "VeryLazy",
    config = function()
      local icons = ICONS

      require("telescope").setup {
        defaults = {
          prompt_prefix = icons.ui.scope .. " ",
          selection_caret = icons.ui.arrowReturn .. " ",
          path_display = { "smart" },
        },
      }
    end,
  },
}

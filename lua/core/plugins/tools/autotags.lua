return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ nvim-ts-autotag                                          │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = false,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      }
    end,
  },
}

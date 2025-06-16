return {
  {
    "windwp/nvim-autopairs",
    enabled = VX.plugins.highlight.autopairs,
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
}

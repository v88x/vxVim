return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ nvim-dap                                                 │
  -- │ debugging                                                │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
    config = function() end,
  },
}

return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ mason                                                    │
  -- │ package manager for LSP, DAP, linters, formatters        │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {},
  },
  { import = "core.plugins.ui" },
  { import = "core.plugins.tools" },
  { import = "core.plugins.lsp" },
  { import = "core.plugins.cmp" },
  { import = "core.plugins.fmt" },
  { import = "core.plugins.git" },
}

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local path = "config.lsp.servers"
      local glob_path = vim.fn.stdpath "config" .. "/lua/" .. path:gsub("%.", "/") .. "/*.lua"
      local files = vim.fn.glob(glob_path, false, true)

      local servers = {}

      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        table.insert(servers, name)
      end

      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = servers,
        automatic_installation = true,
      }

      local lspconfig = require "lspconfig"
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local function on_attach(client, bufnr) end

      for _, name in ipairs(servers) do
        local ok, setup_fn = pcall(require, path .. "." .. name)
        if ok and type(setup_fn) == "function" then
          setup_fn(lspconfig, capabilities, on_attach)
        end
      end
    end,
  },
}

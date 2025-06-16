return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", build = ":MasonUpdate" },
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup mason first
      require("mason").setup()
      
      -- Get server configurations
      local path = "config.lsp.servers"
      local config_dir = vim.fn.stdpath("config") .. "/lua/" .. path:gsub("%.", "/")
      
      -- Check if servers directory exists
      if vim.fn.isdirectory(config_dir) == 0 then
        vim.notify("LSP servers directory not found: " .. config_dir, vim.log.levels.WARN)
        return
      end
      
      local glob_path = config_dir .. "/*.lua"
      local files = vim.fn.glob(glob_path, false, true)
      
      if #files == 0 then
        vim.notify("No LSP server configurations found", vim.log.levels.INFO)
        return
      end

      local servers = {}
      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        table.insert(servers, name)
      end

      -- Setup mason-lspconfig
      require("mason-lspconfig").setup {
        ensure_installed = servers,
        automatic_installation = true,
      }

      -- Setup LSP servers
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local function on_attach(client, bufnr) end

      for _, name in ipairs(servers) do
        local ok, setup_fn = pcall(require, path .. "." .. name)
        if ok and type(setup_fn) == "function" then
          local success, err = pcall(setup_fn, lspconfig, capabilities, on_attach)
          if not success then
            vim.notify("Failed to setup " .. name .. ": " .. tostring(err), vim.log.levels.ERROR)
          end
        else
          vim.notify("Failed to load config for " .. name, vim.log.levels.WARN)
        end
      end
    end,
  },
}

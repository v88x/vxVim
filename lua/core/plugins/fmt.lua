return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    dependencies = {
      {
        "zapling/mason-conform.nvim",
        opts = function()
          local formatters = require("config.fmt").formatters_by_ft
          local seen, unique = {}, {}

          for _, list in pairs(formatters) do
            for _, fmt in ipairs(list) do
              if not seen[fmt] then
                seen[fmt] = true
                table.insert(unique, fmt)
              end
            end
          end

          return {
            ensure_installed = unique,
            automatic_installation = true,
          }
        end,
      },
    },
    config = function()
      local formatter = VX.plugins.formatter or {}
      local formatters = require "config.fmt"

      require("conform").setup {
        formatters_by_ft = formatters.formatters_by_ft,
        format_on_save = formatter.format_on_save and {
          timeout_ms = formatter.timeout or 500,
          lsp_fallback = false,
          async = formatter.async or false,
        } or nil,
      }
    end,
  },
}

--      ██╗███████╗ ██████╗ ███╗   ██╗██╗     ███████╗
--      ██║██╔════╝██╔═══██╗████╗  ██║██║     ██╔════╝
--      ██║███████╗██║   ██║██╔██╗ ██║██║     ███████╗
-- ██   ██║╚════██║██║   ██║██║╚██╗██║██║     ╚════██║
-- ╚█████╔╝███████║╚██████╔╝██║ ╚████║███████╗███████║
--  ╚════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ JSON LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ JSON SETTINGS ────────────────────────────────────────╮
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
        format = { enable = true },
      },
    },
  }
end

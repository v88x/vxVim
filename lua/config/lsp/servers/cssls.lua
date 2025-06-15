--  ██████╗███████╗███████╗██╗     ███████╗
-- ██╔════╝██╔════╝██╔════╝██║     ██╔════╝
-- ██║     ███████╗███████╗██║     ███████╗
-- ██║     ╚════██║╚════██║██║     ╚════██║
-- ╚██████╗███████║███████║███████╗███████║
--  ╚═════╝╚══════╝╚══════╝╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ CSS LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ CSS SETTINGS ─────────────────────────────────────────╮
    settings = {
      css = {
        validate = true,
      },
      less = {
        validate = true,
      },
      scss = {
        validate = true,
      },
      
      -- ░ Privacy settings
      telemetry = {
        enable = false,  -- ░ Disable telemetry
      },
    },
  }
end

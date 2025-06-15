-- ██╗   ██╗████████╗███████╗██╗     ███████╗
-- ██║   ██║╚══██╔══╝██╔════╝██║     ██╔════╝
-- ██║   ██║   ██║   ███████╗██║     ███████╗
-- ╚██╗ ██╔╝   ██║   ╚════██║██║     ╚════██║
--  ╚████╔╝    ██║   ███████║███████╗███████║
--   ╚═══╝     ╚═╝   ╚══════╝╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ TYPESCRIPT LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.vtsls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ TYPESCRIPT SETTINGS ──────────────────────────────────╮
    settings = {
      typescript = {
        preferences = {
          disableSuggestions = false,
          quotePreference = "double",
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          includeCompletionsWithSnippetText = false,  -- ░ Disable telemetry
        },
        
        -- ░ Privacy settings
        telemetry = { 
          enable = false  -- ░ Disable telemetry
        },
      },
    },
  }
end

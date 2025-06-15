-- ██████╗ ██╗   ██╗██████╗ ██╗ ██████╗ ██╗  ██╗████████╗
-- ██╔══██╗╚██╗ ██╔╝██╔══██╗██║██╔════╝ ██║  ██║╚══██╔══╝
-- ██████╔╝ ╚████╔╝ ██████╔╝██║██║  ███╗███████║   ██║   
-- ██╔═══╝   ╚██╔╝  ██╔══██╗██║██║   ██║██╔══██║   ██║   
-- ██║        ██║   ██║  ██║██║╚██████╔╝██║  ██║   ██║   
-- ╚═╝        ╚═╝   ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   

-- ═══════════════════════════════════════════════════════════
-- ░ PYTHON LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ PYTHON ANALYSIS SETTINGS ─────────────────────────────╮
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "strict",            -- ░ Enhanced type checking
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
          logLevel = "Error",
          
          -- ░ Diagnostic overrides
          diagnosticSeverityOverrides = {
            reportMissingImports = "error",
            reportUndefinedVariable = "error",
          },
        },
      },
    },
  }
end

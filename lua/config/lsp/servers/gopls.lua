--  ██████╗  ██████╗ ██████╗ ██╗     ███████╗
-- ██╔════╝ ██╔═══██╗██╔══██╗██║     ██╔════╝
-- ██║  ███╗██║   ██║██████╔╝██║     ███████╗
-- ██║   ██║██║   ██║██╔═══╝ ██║     ╚════██║
-- ╚██████╔╝╚██████╔╝██║     ███████╗███████║
--  ╚═════╝  ╚═════╝ ╚═╝     ╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ GO LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    
    -- ╭─ ROOT DIRECTORY ───────────────────────────────────────╮
    root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod"),

    -- ╭─ GOPLS SETTINGS ───────────────────────────────────────╮
    settings = {
      gopls = {
        -- ░ Basic settings
        completeUnimported = true,
        usePlaceholders = true,
        
        -- ░ Performance optimizations
        staticcheck = true,
        vulncheck = "Imports",
        experimentalPostfixCompletions = true,
        
        -- ░ Privacy settings
        telemetryMode = "off",              -- ░ Disable telemetry
        completionDocumentation = false,    -- ░ Disable telemetry
        
        -- ░ Code analysis
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
end

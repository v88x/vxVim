-- ███████╗███████╗██╗     ██╗███╗   ██╗████████╗
-- ██╔════╝██╔════╝██║     ██║████╗  ██║╚══██╔══╝
-- █████╗  ███████╗██║     ██║██╔██╗ ██║   ██║   
-- ██╔══╝  ╚════██║██║     ██║██║╚██╗██║   ██║   
-- ███████╗███████║███████╗██║██║ ╚████║   ██║   
-- ╚══════╝╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝   ╚═╝   

-- ═══════════════════════════════════════════════════════════
-- ░ ESLINT LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ ESLINT SETTINGS ──────────────────────────────────────╮
    -- No additional settings needed
  }
end

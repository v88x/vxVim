-- ███████╗ ██████╗ ██╗     ███████╗
-- ██╔════╝██╔═══██╗██║     ██╔════╝
-- ███████╗██║   ██║██║     ███████╗
-- ╚════██║██║▄▄ ██║██║     ╚════██║
-- ███████║╚██████╔╝███████╗███████║
-- ╚══════╝ ╚══▀▀═╝ ╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ SQL LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.sqls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ SQL SETTINGS ─────────────────────────────────────────╮
    settings = {
      sqls = {
        connections = {},
      },
    },
  }
end

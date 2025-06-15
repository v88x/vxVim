-- ██╗  ██╗████████╗███╗   ███╗██╗     
-- ██║  ██║╚══██╔══╝████╗ ████║██║     
-- ███████║   ██║   ██╔████╔██║██║     
-- ██╔══██║   ██║   ██║╚██╔╝██║██║     
-- ██║  ██║   ██║   ██║ ╚═╝ ██║███████╗
-- ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ HTML LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ HTML SETTINGS ────────────────────────────────────────╮
    settings = {
      html = {
        format = {
          enable = true,
        },
        hover = {
          documentation = true,
          references = true,
        },
        validate = true,
      },
    },
  }
end

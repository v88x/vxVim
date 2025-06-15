-- ██████╗  █████╗ ███████╗██╗  ██╗██╗     ███████╗
-- ██╔══██╗██╔══██╗██╔════╝██║  ██║██║     ██╔════╝
-- ██████╔╝███████║███████╗███████║██║     ███████╗
-- ██╔══██╗██╔══██║╚════██║██╔══██║██║     ╚════██║
-- ██████╔╝██║  ██║███████║██║  ██║███████╗███████║
-- ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ BASH LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ FILE TYPES ───────────────────────────────────────────╮
    filetypes = { "sh", "bash" },
    
    -- ╭─ ROOT DIRECTORY ───────────────────────────────────────╮
    root_dir = require("lspconfig.util").root_pattern(".git", ".bashrc", ".bash_profile", "package.json"),
    
    -- ╭─ BASH SETTINGS ────────────────────────────────────────╮
    settings = {
      bashIde = {
        globPattern = "*@(.sh|.inc|.bash|.command)",
      },
    },
  }
end

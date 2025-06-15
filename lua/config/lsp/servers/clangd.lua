--  ██████╗██╗      █████╗ ███╗   ██╗ ██████╗ ██████╗ 
-- ██╔════╝██║     ██╔══██╗████╗  ██║██╔════╝ ██╔══██╗
-- ██║     ██║     ███████║██╔██╗ ██║██║  ███╗██║  ██║
-- ██║     ██║     ██╔══██║██║╚██╗██║██║   ██║██║  ██║
-- ╚██████╗███████╗██║  ██║██║ ╚████║╚██████╔╝██████╔╝
--  ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ 

-- ═══════════════════════════════════════════════════════════
-- ░ CLANGD C/C++ LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ COMMAND LINE ARGUMENTS ───────────────────────────────╮
    cmd = {
      "clangd",
      -- ░ Header management
      "--header-insertion=never",
      
      -- ░ Logging and performance
      "--log=error",
      "--pch-storage=memory",
      
      -- ░ Code completion
      "--limit-results=100",
      "--all-scopes-completion",
      "--completion-style=bundled",
      "--function-arg-placeholders",
      
      -- ░ Analysis features
      "--background-index",
      "--clang-tidy",
      "--cross-file-rename",              -- ░ Enhanced refactoring
      "--suggest-missing-includes",       -- ░ Smart includes
      
      -- ░ Style and configuration  
      "--fallback-style=none",
      "--use-dirty-headers",
      "--enable-config",                  -- ░ Use .clangd config files
    },
    
    -- ╭─ FILE TYPES ───────────────────────────────────────────╮
    filetypes = { "c", "cpp", "objc", "objcpp", "m", "mm", "h", "hpp" },
    
    -- ╭─ ROOT DIRECTORY ───────────────────────────────────────╮
    root_dir = require("lspconfig.util").root_pattern(
      "compile_commands.json",
      "compile_flags.txt", 
      ".git"
    ),
  }
end

--  ██████╗ ███╗   ███╗███╗   ██╗██╗███████╗██╗  ██╗ █████╗ ██████╗ ██████╗ 
-- ██╔═══██╗████╗ ████║████╗  ██║██║██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗
-- ██║   ██║██╔████╔██║██╔██╗ ██║██║███████╗███████║███████║██████╔╝██████╔╝
-- ██║   ██║██║╚██╔╝██║██║╚██╗██║██║╚════██║██╔══██║██╔══██║██╔══██╗██╔═══╝ 
-- ╚██████╔╝██║ ╚═╝ ██║██║ ╚████║██║███████║██║  ██║██║  ██║██║  ██║██║     
--  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     

-- ═══════════════════════════════════════════════════════════
-- ░ C# OMNISHARP LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.omnisharp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ OMNISHARP EXECUTABLE ─────────────────────────────────╮
    cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
    
    -- ╭─ OMNISHARP SETTINGS ───────────────────────────────────╮
    enable_import_completion = true,
    organize_imports_on_format = true,
    enable_roslyn_analyzers = true,
    
    -- ╭─ ROOT DIRECTORY ───────────────────────────────────────╮
    root_dir = function()
      return vim.loop.cwd()
    end,
    
    -- ╭─ SETTINGS ─────────────────────────────────────────────╮
    -- No additional settings needed
  }
end

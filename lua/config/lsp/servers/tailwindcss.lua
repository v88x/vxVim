-- ████████╗ █████╗ ██╗██╗     ██╗    ██╗██╗███╗   ██╗██████╗  ██████╗███████╗███████╗
-- ╚══██╔══╝██╔══██╗██║██║     ██║    ██║██║████╗  ██║██╔══██╗██╔════╝██╔════╝██╔════╝
--    ██║   ███████║██║██║     ██║ █╗ ██║██║██╔██╗ ██║██║  ██║██║     ███████╗███████╗
--    ██║   ██╔══██║██║██║     ██║███╗██║██║██║╚██╗██║██║  ██║██║     ╚════██║╚════██║
--    ██║   ██║  ██║██║███████╗╚███╔███╔╝██║██║ ╚████║██████╔╝╚██████╗███████║███████║
--    ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝╚═════╝  ╚═════╝╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ TAILWIND CSS LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    
    -- ╭─ SUPPORTED FILE TYPES ─────────────────────────────────╮
    filetypes = {
      "html",
      "mdx", 
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    },
    
    -- ╭─ INITIALIZATION OPTIONS ───────────────────────────────╮
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
      },
    },
    
    -- ╭─ TAILWIND SETTINGS ────────────────────────────────────╮
    settings = {
      tailwindCSS = {
        -- ░ Linting configuration
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidConfigPath = "error",
          invalidScreen = "error",
          invalidTailwindDirective = "error",
          invalidVariant = "error",
          recommendedVariantOrder = "warning",
        },
        
        -- ░ Experimental features  
        experimental = {
          classRegex = {
            "tw`([^`]*)",
            'tw="([^"]*)',
            'tw={"([^"}]*)',
            "tw\\.\\w+`([^`]*)",
            "tw\\(.*?\\)`([^`]*)",
            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "classnames\\(([^)]*)\\)", "'([^']*)'" },
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
        
        -- ░ Validation
        validate = true,
      },
    },
  }
end

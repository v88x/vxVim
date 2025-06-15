-- ██╗     ██╗   ██╗ █████╗     ██╗     ███████╗
-- ██║     ██║   ██║██╔══██╗    ██║     ██╔════╝
-- ██║     ██║   ██║███████║    ██║     ███████╗
-- ██║     ██║   ██║██╔══██║    ██║     ╚════██║
-- ███████╗╚██████╔╝██║  ██║    ███████╗███████║
-- ╚══════╝ ╚═════╝ ╚═╝  ╚═╝    ╚══════╝╚══════╝

-- ═══════════════════════════════════════════════════════════
-- ░ LUA LANGUAGE SERVER CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return function(lspconfig, capabilities, on_attach)
  lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        -- ╭─ RUNTIME SETTINGS ─────────────────────────────────╮
        runtime = {
          version = "LuaJIT",
        },

        -- ╭─ TELEMETRY ────────────────────────────────────────╮
        telemetry = {
          enable = false,  -- ░ Disable telemetry
        },

        -- ╭─ FORMATTING ───────────────────────────────────────╮
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
          },
        },
      },
    },
  }
end

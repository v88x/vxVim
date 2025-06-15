-- ███████╗███╗   ███╗████████╗
-- ██╔════╝████╗ ████║╚══██╔══╝
-- █████╗  ██╔████╔██║   ██║   
-- ██╔══╝  ██║╚██╔╝██║   ██║   
-- ██║     ██║ ╚═╝ ██║   ██║   
-- ╚═╝     ╚═╝     ╚═╝   ╚═╝   
                            
-- ═══════════════════════════════════════════════════════════
-- ░ CODE FORMATTERS CONFIGURATION
-- ═══════════════════════════════════════════════════════════

return {
  formatters_by_ft = {
    -- ╭─ LUA ──────────────────────────────────────────────────╮
    lua = { "stylua" },

    -- ╭─ JAVASCRIPT & TYPESCRIPT ─────────────────────────────╮ 
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    -- ╭─ WEB TECHNOLOGIES ─────────────────────────────────────╮
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },

    -- ╭─ DATA FORMATS ─────────────────────────────────────────╮
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    -- ╭─ SYSTEM LANGUAGES ─────────────────────────────────────╮
    cpp = { "clang-format" },
    c = { "clang-format" },
    go = { "goimports", "gofmt" },
  },
}

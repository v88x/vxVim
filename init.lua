-- ██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
-- ██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
-- ██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
-- ██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║██║ ╚████║██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝

-- ═══════════════════════════════════════════════════════════
-- ░ NEOVIM ENTRY POINT
-- ═══════════════════════════════════════════════════════════

require "vxrc"                -- ░ Global configuration
require "core.utils.version"  -- ░ Version information  
require "core.utils.icons"    -- ░ Icon definitions
require "config.options"      -- ░ Neovim options
require "core.bootstrap"      -- ░ Plugin manager setup
require "config.mappings"     -- ░ Key bindings

-- ░ Setup update checker
require("core.utils.updater").setup()

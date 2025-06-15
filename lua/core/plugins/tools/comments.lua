return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Comment                                                  │
  -- │ commenting tool                                          │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "numToStr/Comment.nvim",
    opts = {},
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup {
        ---@type boolean
        padding = true,
        ---@type string|function
        ignore = nil,

        ---@type table
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },

        ---@type table
        toggler = {
          line = "gcc",
          block = "gbc",
        },

        ---@type table
        opleader = {
          line = "gc",
          block = "gb",
        },

        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

        ---@type function|nil
        post_hook = nil,
      }
    end,
  },
  {
    "LudoPinelli/comment-box.nvim",
    lazy = true,
  },
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ todo-comments                                            │
  -- │ todo comment highlighting                                │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "folke/todo-comments.nvim",
    lazy = false,
    event = "BufEnter",
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        WARN = { alt = { "WARNING" } },
        PERF = { alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      },
      highlight = {
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
    },
    -- keymaps moved to mappings.lua
  },
}

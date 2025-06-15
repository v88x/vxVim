return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ noice                                                    │
  -- │ cmdline and popupmenu                                    │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "folke/noice.nvim",
    lazy = false,
    opts = {
      messages = { enabled = true },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      views = {
        mini = {
          position = {
            row = -1,
          },
          timeout = 3000,
        },
      },
    },
  },
}

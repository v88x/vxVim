return {
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ nvim-tree                                                │
  -- │ file explorer                                            │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      local icons = ICONS

      local git_icons = {
        unstaged = icons.git.unstaged,
        staged = icons.git.staged,
        unmerged = icons.git.unmerged,
        renamed = icons.git.renamed,
        untracked = icons.git.add,
        deleted = icons.git.deleted,
        ignored = icons.git.ignored,
      }

      require("nvim-tree").setup {
        sort_by = "name",
        on_attach = on_attach,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        git = {
          enable = true,
          ignore = VX.plugins.tree.hide_gitignore,
        },
        view = {
          side = VX.plugins.tree.side,
          width = VX.plugins.tree.width,
          number = false,
          relativenumber = false,
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = icons.ui.circle,
            info = icons.ui.circle,
            warning = icons.ui.circle,
            error = icons.ui.circle,
          },
        },
        renderer = {
          group_empty = false,
          highlight_opened_files = "none",
          root_folder_label = VX.plugins.tree.show_root_path,
          add_trailing = false,
          highlight_git = VX.plugins.tree.git_hl,
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              none = "  ",
            },
          },
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            git_placement = "after",
            webdev_colors = true,
            padding = " ",
            symlink_arrow = " ➔ ",
            glyphs = {
              git = git_icons,
              folder = icons.folder,
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = VX.plugins.tree.quit_on_open,
            resize_window = false,
          },
        },
      }
    end,
  },
}

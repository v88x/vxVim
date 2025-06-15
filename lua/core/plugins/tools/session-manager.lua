local path_present, Path = pcall(require, "plenary.path")
if not path_present then
  return
end

return {
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = function()
      local config_group = vim.api.nvim_create_augroup("SessionManagerGroup", {})

      require("session_manager").setup {
        sessions_dir = Path:new(vim.fn.stdpath "data", "sessions"),
        path_replacer = "__",
        colon_replacer = "++",
        autoload_mode = VX.plugins.session.autoload and require("session_manager.config").AutoloadMode.CurrentDir or require("session_manager.config").AutoloadMode.Disabled,
        autosave_last_session = VX.plugins.session.autosave,
        autosave_ignore_not_normal = true,
        autosave_ignore_filetypes = {
          "gitcommit",
          "gitrebase",
        },
        autosave_only_in_session = VX.plugins.session.autosave_only_in_session,
        max_path_length = 80,
      }

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "SessionLoadPost",
        group = config_group,
        callback = function()
          vim.notify("Session loaded!", "info", { title = "Session Manager" })
        end,
      })

      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "SessionSavePost",
        group = config_group,
        callback = function()
          vim.notify("Session saved!", "info", { title = "Session Manager", bufid = 0 })
        end,
      })
    end,
  },
}

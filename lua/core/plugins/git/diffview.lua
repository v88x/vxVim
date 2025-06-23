return {
  {
    "sindrets/diffview.nvim",
    lazy = true,
    enabled = true,
    event = "BufRead",
    config = function()
      local lib = require "diffview.lib"
      local diffview = require "diffview"

      function _G.ToggleDiffviewFileHistory()
        local view = lib.get_current_view()
        if view == nil then
          diffview.file_history()
          return
        end
        view:close()
        lib.dispose_view(view)
      end

      function _G.ToggleDiffviewStatus()
        local view = lib.get_current_view()
        if view == nil then
          diffview.open()
          return
        end
        view:close()
        lib.dispose_view(view)
      end
    end,
  },
}

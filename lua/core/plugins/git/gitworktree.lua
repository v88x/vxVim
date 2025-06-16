return {
  {
    "ThePrimeagen/git-worktree.nvim",
    lazy = false,
    config = function() end,
    opts = {
      change_directory_command = "cd", -- default: "cd",
      update_on_change = true, -- default: true,
      update_on_change_command = "e .", -- default: "e .",
      clearjumps_on_change = true, -- default: true,
      autopush = false, -- default: false,
    },
  },
}

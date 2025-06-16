local M = {}

-- Configuration
local function get_timeout_cmd()
  if vim.fn.executable("timeout") == 1 then
    return "timeout 5"
  elseif vim.fn.executable("gtimeout") == 1 then
    return "gtimeout 5"
  else
    return ""
  end
end

local config = {
  check_interval = 24 * 60 * 60,
  remote = "origin",
  branch = "main",
  update_file = vim.fn.stdpath("config") .. "/.last_update_check",
  notification_timeout = 5000,
  silent_mode = true,
  nvim_config_dir = vim.fn.stdpath("config"),
  timeout_cmd = get_timeout_cmd(),
}

-- File System Utilities
local fs = {
  get_last_check_time = function()
    local file = io.open(config.update_file, "r")
    if not file then
      return 0
    end
    
    local timestamp = file:read("*n") or 0
    file:close()
    return timestamp
  end,

  save_check_time = function()
    local file = io.open(config.update_file, "w")
    if file then
      file:write(tostring(os.time()))
      file:close()
    end
  end,

  should_check_for_updates = function()
    local last_check = fs.get_last_check_time()
    local current_time = os.time()
    return (current_time - last_check) >= config.check_interval
  end,

  is_git_repo = function()
    local git_dir = config.nvim_config_dir .. "/.git"
    return vim.fn.isdirectory(git_dir) == 1
  end,

  create_backup = function()
    local backup_dir = config.nvim_config_dir .. ".backup.update." .. os.date("%Y%m%d_%H%M%S")
    local core_dir = config.nvim_config_dir .. "/lua/core"
    
    if vim.fn.isdirectory(core_dir) == 1 then
      vim.fn.mkdir(backup_dir, "p")
      local success = os.execute("cp -r " .. core_dir .. " " .. backup_dir .. "/")
      
      if success then
        return backup_dir
      end
    end
    
    return nil
  end,

  clean_cache = function()
    local cache_dirs = {
      vim.fn.expand("~/.local/share/nvim"),
      vim.fn.expand("~/.local/state/nvim"),
      vim.fn.expand("~/.cache/nvim"),
    }
    
    for _, dir in ipairs(cache_dirs) do
      if vim.fn.isdirectory(dir) == 1 then
        vim.fn.delete(dir, "rf")
      end
    end
    
    local lock_file = config.nvim_config_dir .. "/lazy-lock.json"
    if vim.fn.filereadable(lock_file) == 1 then
      vim.fn.delete(lock_file)
    end
  end,
}



-- Git Operations
local function run_git_command(cmd, callback)
  local timeout_prefix = config.timeout_cmd ~= "" and config.timeout_cmd .. " " or ""
  local full_cmd = "cd " .. config.nvim_config_dir .. " && " .. timeout_prefix .. cmd .. " 2>/dev/null"
  
  vim.fn.jobstart(full_cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_exit = function(_, exit_code)
      if callback then
        callback(exit_code == 0, "")
      end
    end,
    on_stdout = function(_, data)
      if callback then
        local result = table.concat(data, "\n"):gsub("%s+$", "")
        callback(true, result)
      end
    end,
  })
end

local function run_git_command_sync(cmd)
  local timeout_prefix = config.timeout_cmd ~= "" and config.timeout_cmd .. " " or ""
  local full_cmd = "cd " .. config.nvim_config_dir .. " && " .. timeout_prefix .. cmd .. " 2>/dev/null"
  local handle = io.popen(full_cmd)
  
  if not handle then
    return false, ""
  end
  
  local result = handle:read("*a")
  local success = handle:close()
  
  if result then
    result = result:gsub("%s+$", "")
    result = result:gsub("^%s+", "")
  end
  
  return success and result ~= nil, result or ""
end

local git = {
  run_command = run_git_command,
  run_command_sync = run_git_command_sync,

  fetch_updates = function(callback)
    run_git_command("git fetch " .. config.remote .. " " .. config.branch .. " --quiet", callback)
  end,

  check_commits_behind = function()
    local cmd = "git diff --name-only HEAD.." .. config.remote .. "/" .. config.branch .. " | grep '^lua/core/'"
    local success, output = run_git_command_sync(cmd)
    
    if success and output then
      local count = 0
      for _ in output:gmatch("[^\r\n]+") do
        count = count + 1
      end
      
      return count > 0, count
    end
    
    return false, 0
  end,

  get_latest_commits = function()
    local cmd = "git log --oneline --graph HEAD.." .. config.remote .. "/" .. config.branch .. " -- lua/core/ | head -3"
    local success, output = run_git_command_sync(cmd)
    
    if success and output and output ~= "" then
      return output
    end
    
    return "Core improvements and fixes"
  end,



  get_remote_url = function()
    local remote_url_cmd = "cd " .. config.nvim_config_dir .. " && git remote get-url " .. config.remote
    local handle = io.popen(remote_url_cmd)
    
    if not handle then
      return nil
    end
    
    local remote_url = handle:read("*a"):gsub("%s+$", "")
    handle:close()
    
    return remote_url ~= "" and remote_url or nil
  end,
}

-- Update Operations
local updater = {
  update_core_files = function()
    local temp_dir = "/tmp/vxvim_update_" .. os.time()
    local remote_url = git.get_remote_url()
    
    if not remote_url then
      return false, "Failed to get remote URL"
    end
    
    local clone_cmd = "git clone --depth 1 -b " .. config.branch .. " " .. remote_url .. " " .. temp_dir .. " --quiet 2>/dev/null"
    local clone_success = os.execute(clone_cmd)
    
    if not clone_success then
      return false, "Failed to clone repository"
    end
    
    local old_core = config.nvim_config_dir .. "/lua/core"
    if vim.fn.isdirectory(old_core) == 1 then
      vim.fn.delete(old_core, "rf")
    end
    
    local copy_core_cmd = "cp -r " .. temp_dir .. "/lua/core " .. config.nvim_config_dir .. "/lua/"
    local copy_success = os.execute(copy_core_cmd)
    
    if not copy_success then
      os.execute("rm -rf " .. temp_dir)
      return false, "Failed to copy core files"
    end
    
    local scripts_src = temp_dir .. "/.scripts"
    local scripts_dst = config.nvim_config_dir .. "/.scripts"
    
    if vim.fn.isdirectory(scripts_src) == 1 then
      os.execute("cp -r " .. scripts_src .. " " .. config.nvim_config_dir .. "/")
      os.execute("chmod +x " .. scripts_dst .. "/*.sh")
    end
    
    fs.save_check_time()
    os.execute("rm -rf " .. temp_dir)
    
    return true, "Core updated successfully"
  end,
}

-- Notification System
local notify = {
  show_update_available = function(commits_count, latest_commits)
    local title = "vxVim Update Available"
    local message = string.format(
      "%d core file%s updated!\n\nLatest changes:\n%s\n\nPress <leader>uu to update",
      commits_count,
      commits_count > 1 and "s" or "",
      latest_commits
    )
    
    vim.notify(message, vim.log.levels.INFO, {
      title = title,
      timeout = config.notification_timeout,
    })
  end,

  show_progress = function(message)
    vim.notify(message, vim.log.levels.INFO, {
      title = "vxVim Update",
      timeout = 2000,
    })
  end,

  show_success = function(message)
    vim.notify(message, vim.log.levels.INFO, {
      title = "vxVim Updated",
      timeout = 4000,
    })
  end,

  show_error = function(message)
    vim.notify(message, vim.log.levels.ERROR, {
      title = "Update Error",
      timeout = 5000,
    })
  end,

  show_info = function(message, title, timeout)
    vim.notify(message, vim.log.levels.INFO, {
      title = title or "vxVim",
      timeout = timeout or 2000,
    })
  end,
}

-- Public API
function M.check_for_updates(force)
  if not fs.is_git_repo() then
    return
  end
  
  if not force and not fs.should_check_for_updates() then
    return
  end
  
  fs.save_check_time()
  
  git.fetch_updates(function(fetch_success, _)
    if not fetch_success then
      return
    end
    
    local ok, has_updates, commits_count = pcall(git.check_commits_behind)
    
    if not ok then
      return
    end
    
    if has_updates and commits_count and commits_count > 0 then
      local latest_commits = git.get_latest_commits()
      notify.show_update_available(commits_count, latest_commits)
    end
  end)
end

function M.update_config()
  if not fs.is_git_repo() then
    notify.show_error("Not a git repository. Please reinstall vxVim.")
    return
  end
  
  local success, _ = git.run_command_sync("git fetch " .. config.remote .. " " .. config.branch .. " --quiet")
  
  if not success then
    notify.show_error("Failed to check for updates. Check your internet connection.")
    return
  end
  
  local ok, has_updates, commits_count = pcall(git.check_commits_behind)
  
  if not ok then
    notify.show_error("Error checking for updates. Please try again later.")
    return
  end
  
  if not has_updates then
    notify.show_info("Already up to date!", "vxVim")
    return
  end
  
  local latest_commits = git.get_latest_commits()
  
  local info_message = string.format(
    "Core updates available (%d files)\n\nChanges:\n%s\n\nYour personal configs will be preserved",
    commits_count,
    latest_commits
  )
  
  notify.show_info(info_message, "Update Available", 8000)
  
  vim.ui.select(
    { "Yes, update core now", "No, cancel" },
    {
      prompt = "Update vxVim core configuration?",
      format_item = function(item)
        return item
      end,
    },
    function(choice)
      if choice and choice:find("Yes") then
        M.perform_update()
      end
    end
  )
end

function M.perform_update()
  notify.show_progress("Creating backup...")
  
  local backup_dir = fs.create_backup()
  
  if not backup_dir then
    notify.show_error("Failed to create backup")
    return
  end
  
  notify.show_progress("Cleaning cache...")
  fs.clean_cache()
  
  notify.show_progress("Updating core files...")
  
  local success, message = updater.update_core_files()
  
  if success then
    notify.show_success(
      "Core updated successfully!\n\n" ..
      "Backup: " .. vim.fn.fnamemodify(backup_dir, ":t") .. "\n" ..
      "Restart Neovim to apply changes\n" ..
      "Run :Lazy sync to update plugins"
    )
  else
    notify.show_error("Update failed: " .. message)
  end
end

function M.force_check()
  local old_silent = config.silent_mode
  config.silent_mode = false
  M.check_for_updates(true)
  config.silent_mode = old_silent
end

function M.setup()
  vim.defer_fn(function()
    local ok, err = pcall(M.check_for_updates)
    if not ok and not config.silent_mode then
      vim.notify("Error in update checker: " .. tostring(err), vim.log.levels.DEBUG)
    end
  end, 5000)
end

-- Commands
vim.api.nvim_create_user_command("VxVimUpdate", function()
  M.update_config()
end, { desc = "Update vxVim core configuration" })

vim.api.nvim_create_user_command("VxVimCheckUpdates", function()
  M.force_check()
end, { desc = "Check for vxVim updates" })

return M 
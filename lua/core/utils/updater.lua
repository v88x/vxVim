local M = {}

-- ╭─ CONFIGURATION ────────────────────────────────────────╮
local config = {
  check_interval = 24 * 60 * 60, -- 24 hours in seconds
  remote = "origin",
  branch = "main",
  update_file = vim.fn.stdpath("config") .. "/.last_update_check",
  notification_timeout = 5000, -- 5 seconds
  silent_mode = true, -- Не показывать ошибки
  nvim_config_dir = vim.fn.stdpath("config"),
}

-- ╭─ UTILITIES ────────────────────────────────────────────╮
local function get_last_check_time()
  local file = io.open(config.update_file, "r")
  if not file then
    return 0
  end
  
  local timestamp = file:read("*n") or 0
  file:close()
  return timestamp
end

local function save_check_time()
  local file = io.open(config.update_file, "w")
  if file then
    file:write(tostring(os.time()))
    file:close()
  end
end

local function should_check_for_updates()
  local last_check = get_last_check_time()
  local current_time = os.time()
  return (current_time - last_check) >= config.check_interval
end

local function is_git_repo()
  local git_dir = config.nvim_config_dir .. "/.git"
  return vim.fn.isdirectory(git_dir) == 1
end

-- ╭─ GIT OPERATIONS ───────────────────────────────────────╮
local function run_git_command(cmd, callback)
  -- Полностью тихая команда с тайм-аутом
  local full_cmd = "cd " .. config.nvim_config_dir .. " && timeout 5 " .. cmd .. " 2>/dev/null"
  
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
  local full_cmd = "cd " .. config.nvim_config_dir .. " && timeout 5 " .. cmd .. " 2>/dev/null"
  local handle = io.popen(full_cmd)
  
  if not handle then
    return false, ""
  end
  
  local result = handle:read("*a")
  local success = handle:close()
  
  return success, result and result:gsub("%s+$", "") or ""
end

local function fetch_updates(callback)
  run_git_command("git fetch " .. config.remote .. " " .. config.branch .. " --quiet", callback)
end

local function check_commits_behind()
  local cmd = "git diff --name-only HEAD.." .. config.remote .. "/" .. config.branch .. " | grep '^lua/core/' | wc -l"
  local success, output = run_git_command_sync(cmd)
  
  if success and output then
    local count = tonumber(output:gsub("%s+", "")) or 0
    return count > 0, count
  end
  
  return false, 0
end

local function get_latest_commits()
  local cmd = "git log --oneline --graph HEAD.." .. config.remote .. "/" .. config.branch .. " -- lua/core/ | head -3"
  local success, output = run_git_command_sync(cmd)
  
  if success and output and output ~= "" then
    return output
  end
  
  return "• Core improvements and fixes"
end

local function get_changed_files()
  local cmd = "git diff --name-only HEAD.." .. config.remote .. "/" .. config.branch .. " | grep '^lua/core/' | head -5"
  local success, output = run_git_command_sync(cmd)
  
  if success and output and output ~= "" then
    return output:gsub("\n", "\n• ")
  end
  
  return "Core configuration files"
end

-- ╭─ FILE OPERATIONS ──────────────────────────────────────╮
local function create_backup()
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
end

local function clean_cache()
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
  
  -- Remove lazy-lock.json
  local lock_file = config.nvim_config_dir .. "/lazy-lock.json"
  if vim.fn.filereadable(lock_file) == 1 then
    vim.fn.delete(lock_file)
  end
end

local function update_core_files()
  local temp_dir = "/tmp/vxvim_update_" .. os.time()
  local remote_url_cmd = "cd " .. config.nvim_config_dir .. " && git remote get-url " .. config.remote
  local handle = io.popen(remote_url_cmd)
  
  if not handle then
    return false, "Failed to get remote URL"
  end
  
  local remote_url = handle:read("*a"):gsub("%s+$", "")
  handle:close()
  
  if remote_url == "" then
    return false, "Remote URL not found"
  end
  
  -- Clone to temp directory
  local clone_cmd = "git clone --depth 1 -b " .. config.branch .. " " .. remote_url .. " " .. temp_dir .. " --quiet 2>/dev/null"
  local clone_success = os.execute(clone_cmd)
  
  if not clone_success then
    return false, "Failed to clone repository"
  end
  
  -- Remove old core folder
  local old_core = config.nvim_config_dir .. "/lua/core"
  if vim.fn.isdirectory(old_core) == 1 then
    vim.fn.delete(old_core, "rf")
  end
  
  -- Copy new core folder
  local copy_core_cmd = "cp -r " .. temp_dir .. "/lua/core " .. config.nvim_config_dir .. "/lua/"
  local copy_success = os.execute(copy_core_cmd)
  
  if not copy_success then
    -- Cleanup and return error
    os.execute("rm -rf " .. temp_dir)
    return false, "Failed to copy core files"
  end
  
  -- Copy scripts folder
  local scripts_src = temp_dir .. "/.scripts"
  local scripts_dst = config.nvim_config_dir .. "/.scripts"
  
  if vim.fn.isdirectory(scripts_src) == 1 then
    os.execute("cp -r " .. scripts_src .. " " .. config.nvim_config_dir .. "/")
    os.execute("chmod +x " .. scripts_dst .. "/*.sh")
  end
  
  -- Update timestamp
  save_check_time()
  
  -- Cleanup
  os.execute("rm -rf " .. temp_dir)
  
  return true, "Core updated successfully"
end

-- ╭─ NOTIFICATIONS ────────────────────────────────────────╮
local function show_update_notification(commits_count, latest_commits)
  local title = "🚀 vxVim Update Available"
  local message = string.format(
    "%d core file%s updated!\n\n📝 Latest changes:\n%s\n\n💡 Press <leader>uu to update",
    commits_count,
    commits_count > 1 and "s" or "",
    latest_commits
  )
  
  vim.notify(message, vim.log.levels.INFO, {
    title = title,
    timeout = config.notification_timeout,
  })
end

local function show_progress_notification(message)
  vim.notify(message, vim.log.levels.INFO, {
    title = "🔄 vxVim Update",
    timeout = 2000,
  })
end

local function show_success_notification(message)
  vim.notify(message, vim.log.levels.INFO, {
    title = "✅ vxVim Updated",
    timeout = 4000,
  })
end

local function show_error_notification(message)
  vim.notify(message, vim.log.levels.ERROR, {
    title = "❌ Update Error",
    timeout = 5000,
  })
end

-- ╭─ UPDATE CHECKER ───────────────────────────────────────╮
function M.check_for_updates(force)
  -- Skip if not a git repo
  if not is_git_repo() then
    return
  end
  
  -- Skip if not time to check (unless forced)
  if not force and not should_check_for_updates() then
    return
  end
  
  -- Update check timestamp
  save_check_time()
  
  -- Fetch updates asynchronously
  fetch_updates(function(fetch_success, _)
    -- В тихом режиме просто игнорируем ошибки
    if not fetch_success and config.silent_mode and not force then
      return
    end
    
    -- Check if we're behind
    local has_updates, commits_count = check_commits_behind()
    
    if has_updates and commits_count > 0 then
      local latest_commits = get_latest_commits()
      show_update_notification(commits_count, latest_commits)
    end
  end)
end

-- ╭─ MANUAL UPDATE ────────────────────────────────────────╮
function M.update_config()
  if not is_git_repo() then
    show_error_notification("Not a git repository. Please reinstall vxVim.")
    return
  end
  
  -- Check for updates first
  local success, _ = run_git_command_sync("git fetch " .. config.remote .. " " .. config.branch .. " --quiet")
  
  if not success then
    show_error_notification("Failed to check for updates. Check your internet connection.")
    return
  end
  
  local has_updates, commits_count = check_commits_behind()
  
  if not has_updates then
    vim.notify("Already up to date!", vim.log.levels.INFO, {
      title = "✅ vxVim",
      timeout = 2000,
    })
    return
  end
  
  -- Show update info
  local latest_commits = get_latest_commits()
  local changed_files = get_changed_files()
  
  local info_message = string.format(
    "Core updates available (%d files)\n\n📝 Changes:\n%s\n\n📁 Files:\n• %s\n\n⚠️  Your personal configs will be preserved",
    commits_count,
    latest_commits,
    changed_files
  )
  
  vim.notify(info_message, vim.log.levels.INFO, {
    title = "🔄 Update Available",
    timeout = 8000,
  })
  
  -- Ask for confirmation
  vim.ui.select(
    { "✅ Yes, update core now", "❌ No, cancel" },
    {
      prompt = "🔄 Update vxVim core configuration?",
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
  show_progress_notification("Creating backup...")
  
  local backup_dir = create_backup()
  
  if not backup_dir then
    show_error_notification("Failed to create backup")
    return
  end
  
  show_progress_notification("Cleaning cache...")
  clean_cache()
  
  show_progress_notification("Updating core files...")
  
  local success, message = update_core_files()
  
  if success then
    show_success_notification(
      "Core updated successfully!\n\n" ..
      "📁 Backup: " .. vim.fn.fnamemodify(backup_dir, ":t") .. "\n" ..
      "🔄 Restart Neovim to apply changes\n" ..
      "📦 Run :Lazy sync to update plugins"
    )
  else
    show_error_notification("Update failed: " .. message)
  end
end

-- ╭─ FORCE CHECK ──────────────────────────────────────────╮
function M.force_check()
  local old_silent = config.silent_mode
  config.silent_mode = false
  M.check_for_updates(true)
  config.silent_mode = old_silent
end

-- ╭─ COMMANDS ─────────────────────────────────────────────╮
vim.api.nvim_create_user_command("VxVimUpdate", function()
  M.update_config()
end, { desc = "Update vxVim core configuration" })

vim.api.nvim_create_user_command("VxVimCheckUpdates", function()
  M.force_check()
end, { desc = "Check for vxVim updates" })

-- ╭─ AUTO SETUP ───────────────────────────────────────────╮
function M.setup()
  -- Запускаем проверку через 5 секунд после старта
  vim.defer_fn(function()
    M.check_for_updates()
  end, 5000)
end

return M 
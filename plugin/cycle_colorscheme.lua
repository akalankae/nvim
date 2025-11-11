-- Cycle through available colorschemes
-- Move forward and backward  between colorschemes

local function user_notify(success, theme)
    if success then
        vim.notify("Colorscheme switched to " .. theme, vim.log.levels.INFO)
    else
        vim.notify("Failed to load colorscheme " .. theme, vim.log.levels.INFO)
    end
end

-- NOTE: Assumes i <= highest. This breaks if highest <= 1.
local function next_index(i, highest)
  return (i + 1) == highest and (i + 1) or (i + 1) % highest
end

local function prev_index(i, highest)
  return (i - 1) == 0 and highest or (i - 1)
end

local function get_index(list, value)
  for i, item in ipairs(list) do
    if item == value then
      return i
    end
  end
  return nil
end

local function next_theme()
  local colorschemes = vim.fn.getcompletion("", "color")
  local index = get_index(colorschemes, vim.g.colors_name)
  local new_colorscheme = colorschemes[next_index(index, #colorschemes)]
  local status, _ = pcall(vim.cmd, "colorscheme " .. new_colorscheme)
  user_notify(status, new_colorscheme)
end

local function prev_theme()
  local colorschemes = vim.fn.getcompletion("", "color")
  local index = get_index(colorschemes, vim.g.colors_name)
  local new_colorscheme = colorschemes[prev_index(index, #colorschemes)]
  local status, _ = pcall(vim.cmd, "colorscheme " .. new_colorscheme)
  user_notify(status, new_colorscheme)
end

-- Cycle through colorschemes
-- Keymappings are set in lua/user/keymap.lua
vim.keymap.set({"n", "v", "o"}, "<Plug>(NextColorscheme)", next_theme,
  { noremap = true, silent = true, desc = "Switch to next colorscheme" })
vim.keymap.set({"n", "v", "o"}, "<Plug>(PrevColorscheme)", prev_theme,
  { noremap = true, silent = true, desc = "Switch to previous colorscheme" })

-- Cycle through available colorschemes
-- <ALT-n> moves to next theme, <ALT-p> moves to previous theme.
local themes = vim.fn.getcompletion("", "color")
local curr_i = nil -- index of currently active theme, default is NONE at start 
local NUM_THEMES = #themes

local function announce(success, theme)
    if success then
        print("Colorscheme switched to " .. theme)
    else
        print("Failed to load colorscheme " .. theme)
    end
end

local function cycle_theme_next()
    curr_i = curr_i or 1 -- handle non-initialized state
    local next_i = curr_i + 1
    -- avoid NUM_THEMES = 0 (in lua index 0 is invalid)
    if (next_i ~= NUM_THEMES) then
        next_i = next_i % NUM_THEMES
    end
    local next_theme = themes[next_i]
    local success, _ = pcall(vim.cmd, "colorscheme " .. next_theme)
    announce(success, next_theme)
    curr_i =  next_i
end

local function cycle_theme_prev()
    curr_i = curr_i or 1 -- handle non-initialized state
    -- avoid NUM_THEMES = 0 (in lua index 0 is invalid)
    local prev_i = curr_i + (NUM_THEMES - 1)
    if (prev_i ~= NUM_THEMES) then
        prev_i = prev_i % NUM_THEMES
    end
    local prev_theme = themes[prev_i]
    local success, _ = pcall(vim.cmd, "colorscheme " .. prev_theme)
    announce(success, prev_theme)
    curr_i =  prev_i
end

-- Cycle through colorschemes
-- <Alter-N> cycle through to next, <Alter-P> cycle through to previous
vim.keymap.set("n", "<M-n>", cycle_theme_next, { noremap = true, silent = true })
vim.keymap.set("n", "<M-p>", cycle_theme_prev, { noremap = true, silent = true })

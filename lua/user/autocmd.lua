-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--                          autocmd.lua
--                  Custom autocommands for neovim
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

local opts = { clear = true }
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
local create_user_command = vim.api.nvim_create_user_command
-- ────────────────────────────────────────────────────────────────────────────
-- Line Numbers
-- ────────────────────────────────────────────────────────────────────────────
-- Toggle/untoggle relative/absolute line numbers depending on active/inactive
-- state of the buffers.
local toggle_ln = create_augroup("NumberToggle", opts)

-- relative line numbers in active buffer
create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave" },
  { pattern = "*", command = "set relativenumber", group = toggle_ln }
)

-- absolute line numbers in inactive buffer
create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter" },
  { pattern = "*", command = "set norelativenumber", group = toggle_ln }
)

-- ────────────────────────────────────────────────────────────────────────────
-- Restore Cursor Position
-- ────────────────────────────────────────────────────────────────────────────
-- move cursor to where it was the last time in the file
-- source: https://builtin.com/software-engineering-perspectives/neovim-configuration
create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd([[ execute  "normal! g'\"" ]])
    end
  end,
})

-- ────────────────────────────────────────────────────────────────────────────
-- Register user commands to switch background color between Dark and Light
-- ────────────────────────────────────────────────────────────────────────────
create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    create_user_command("Dark", "set bg=dark", { bang = true })
    create_user_command("Light", "set bg=light", { bang = true })
  end,
  desc = "Register Dark/Light commands to switch background"
})


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Launch toggable terminal session below running neovim instance
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Disable linenumbers in terminal buffers.
-- users/autocmd.lua: Autocommand <Leader>t launches the terminal.
create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("toggable-term", opts),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- ────────────────────────────────────────────────────────────────────────────
-- Stop folds autoclosing in INSERT mode to preserve foldlevel
-- ────────────────────────────────────────────────────────────────────────────
-- These 2 autocommands are thanks to DeepSeek AI (DeepThink)
-- These would stop folds from autoclosing during INSERT mode while you're
-- editing source code. In INSERT mode all folds are left open (foldlevel 99)
-- but when exiting INSERT mode foldlevel is restored to what it was.
create_autocmd("InsertEnter", {
  pattern = "*",
  group = create_augroup("StopFoldsAutoClosing", opts),
  callback = function()
    vim.b.last_foldlevel = vim.wo.foldlevel
    vim.wo.foldlevel = 99
  end,
})

create_autocmd("InsertLeave", {
  pattern = "*",
  group = create_augroup("StopFoldsAutoClosing", opts),
  callback = function()
    if vim.b.last_foldlevel then
      vim.wo.foldlevel = vim.b.last_foldlevel
    end
  end,
})

-- ────────────────────────────────────────────────────────────────────────────
-- Record last used colorscheme on exit
-- ────────────────────────────────────────────────────────────────────────────
local colorscheme_file = vim.fn.stdpath("state") .. "/colorscheme.dat"
local record_colorscheme = create_augroup("RecordColorscheme", opts)

create_autocmd("VimLeave", {
  pattern = "*",
  callback = function()
    local code = vim.fn.writefile({ vim.g.colors_name }, colorscheme_file)
    if code == -1 then
      vim.notify("Failed to write colorscheme to file", vim.log.levels.ERROR)
    end
  end,
  group = record_colorscheme,
  desc = "Keep track of colorscheme"
})

-- ────────────────────────────────────────────────────────────────────────────
-- Load last used colorscheme on startup
-- ────────────────────────────────────────────────────────────────────────────
-- Ensure our colorscheme data file exists, it contains a name of a colorscheme
-- and this colorscheme is available to load.
local function load_last_colorscheme()
  local available_colorschemes = vim.fn.getcompletion("", "color")
  local fallback = "koehler"
  local use_colorscheme = nil
  if vim.uv.fs_stat(colorscheme_file) then
    local last_colorscheme = vim.fn.readfile(colorscheme_file)[1]
    if last_colorscheme and vim.tbl_contains(available_colorschemes, last_colorscheme) then
      use_colorscheme = last_colorscheme
    end
  end
  vim.cmd(string.format("colorscheme %s", use_colorscheme or fallback))
  vim.notify("colorscheme " .. vim.g.colors_name .. " was loaded", vim.log.levels.INFO)
end

create_autocmd("VimEnter", {
  pattern = "*",
  callback = load_last_colorscheme,
  desc = "Load last used colorscheme on startup"
})

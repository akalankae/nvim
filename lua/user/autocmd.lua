--==============================================================================
--                          autocmd.lua
--                  Custom autocommands for neovim
--==============================================================================

local opts = { clear = true }
local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup
local create_user_command = vim.api.nvim_create_user_command
--=============================================================================
-- Line Numbers
--=============================================================================
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

--=============================================================================
-- Restore Cursor Position
--=============================================================================
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

--==============================================================================
-- Register user commands to switch background color between Dark and Light
--==============================================================================
create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    create_user_command("Dark", "set bg=dark", { bang = true })
    create_user_command("Light", "set bg=light", { bang = true })
  end,
})

--==============================================================================
-- Restore last used colorscheme
--==============================================================================
-- We save the colorscheme used on exit of a session to a file, then reload that
-- colorscheme from the file when a new session starts. Colorscheme is recorded
-- in ~/.local/state/nvim/colorscheme.dat
local colorscheme_file = vim.fn.stdpath('state') .. "/colorscheme.dat"
local autoload_colorscheme = create_augroup("AutoloadColorscheme", opts)

create_autocmd("VimLeave", { pattern = "*", group = autoload_colorscheme,
  callback = function()
    local code, errmsg = vim.fn.writefile({vim.g.colors_name}, colorscheme_file)
    if code == -1 then
      vim.notify("Failed to write to colorscheme file: " .. errmsg, vim.log.levels.ERROR)
    end
  end,
  desc = "Record last colorscheme"
})


-- Make sure colorscheme data file exists and it contains the name of a valid
-- colorscheme, if not fallback to a default colorscheme.
local function load_last_colorscheme(fallback)
  local available_colorschemes = vim.fn.getcompletion("", "color")
  local colorscheme = fallback or "default"
  local filedata, err = vim.uv.fs_stat(colorscheme_file)
  -- If colorscheme file was found and it gives a valid colorscheme use it
  if filedata then
    local last_colorscheme = vim.fn.readfile(colorscheme_file)[1]
    if last_colorscheme and vim.tbl_contains(available_colorschemes, last_colorscheme) then
      colorscheme = last_colorscheme
    else
      vim.notify("Could not find colorscheme: " .. last_colorscheme, vim.log.levels.ERROR)
    end
  else
    vim.notify(err, vim.log.levels.ERROR)
  end
  vim.cmd("colorscheme " .. colorscheme)
  vim.notify("Loading colorscheme: " .. colorscheme, vim.log.levels.INFO)
end

create_autocmd("VimEnter", {
  pattern = "*",
  group = autoload_colorscheme,
  callback = function()
    load_last_colorscheme("default")
  end,
  desc = "Load last used colorscheme"
})

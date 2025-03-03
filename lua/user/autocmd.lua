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

--=============================================================================
-- Register user commands to switch background color between Dark and Light
--=============================================================================
create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    create_user_command("Dark", "set bg=dark", { bang = true })
    create_user_command("Light", "set bg=light", { bang = true })
  end,
})


--=============================================================================
-- Launch toggable terminal session below running neovim instance
--=============================================================================
-- Disable linenumbers in terminal buffers.
-- users/autocmd.lua: Autocommand <Leader>t launches the terminal.
create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("toggable-term", opts),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

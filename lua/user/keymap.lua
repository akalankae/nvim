-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--  				keymap.lua
--  			Custom keymappings for neovim
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local util = require "user.util"

-- Setup global LEADER key (Spacebar)
vim.g.mapleader = " "

-- Close window with ctrl-q
util.nnoremap("<C-q>", "<C-w>q")

-- Ctrl-s to save in NORMAL & INSERT modes, and return to relevant mode
util.nnoremap("<C-s>", "<Cmd>update<CR>", { desc = "write buffer if modified" })
util.inoremap("<C-s>", "<Esc><Cmd>update<CR>a", { desc = "write buffer if modified" })

-- Easy navigation between splits
util.nnoremap("<C-l>", "<C-w>l") --> Goto split on left
util.nnoremap("<C-h>", "<C-w>h") --> Goto split on right
util.nnoremap("<C-j>", "<C-w>j") --> Goto split below
util.nnoremap("<C-k>", "<C-w>k") --> Goto split above

-- Transform a horizontal split to a vertical split (e.g. help pages)
-- NOTE: Assumes command is launched from a vertical split below first window
util.nnoremap("<Leader>hv", "<C-w>t<C-w>H<C-w>l")
-- Transform a vertical split to a horizontal split
-- NOTE: Assumes command is run from a horizontal split to right of first one
util.nnoremap("<Leader>vh", "<C-w>t<C-w>K<C-w>j")

-- Clear currently highlighted text with <Escape> key
util.nnoremap("<Esc>", "<cmd>nohlsearch<Bar>:echo<CR>")

-- Source current buffer
util.nnoremap("<M-s>", "<cmd>source %<cr>", { desc = "Source current file" })
util.vnoremap("<M-s>", 'y<cmd>@"<cr>', { desc = "Source visual selection" })

-- In INSERT mode;
-- <C-u> deletes everything from cursor to the start of the line (UNDO LINE)
-- <C-w> deletes the word before the cursor (UNDO WORD),
util.inoremap("<C-l>", "<Esc>viwUea") -- Captalize previous WORD

-- Map ":" in NORMAL mode to open a command-line window ready for work
-- nnoremap(":", "q:i")
util.nnoremap("<C-c>", "<cmd>tabclose<cr>")
util.nnoremap("gn", "<cmd>tabnext<cr>")     -- by default "gT"
util.nnoremap("gp", "<cmd>tabprevious<cr>") -- by default "gT"

-- Go up/down the page, keeping cursor in the middle of the screen
-- credit to Primeagen
util.nnoremap("<C-d>", "<C-d>zz")
util.nnoremap("<C-u>", "<C-u>zz")

-- From "nvim-lua/kickstart.nvim"
-- Make j/k move up/down using "visual" lines instead of actual lines, even when
-- lines are wrapped with window splitting, when motion is not prepended by a
-- count (e.g. k, not with 10k). Uses gk/gj instead of k/j, respectively, when
-- a line count is not given.
util.nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
util.nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- ────────────────────────────────────────────────────────────────────────────
-- Launch toggable terminal session below running neovim instance
-- ────────────────────────────────────────────────────────────────────────────
-- user/autocmd.lua: "TermOpen" disables line numbers
-- :term or :terminal opens a terminal session on a new buffer
-- You will initially be in normal mode (i.e. you cannot enter text into the
-- terminal).  Press "i", "I", "a", "A" or :startinsert to enter Terminal mode.
-- (cursor moves to end of shell prompt) In Terminal mode all keystrokes go to
-- underlying program, EXCEPT when CTRL-\ is entered.
-- When you press CTRL-\ + CTRL-n you enter normal mode,
-- when you press CTRL-\ + CTRL-o you enter normal mode for ONE command only
-- and then go straight back to Terminal mode.
-- Any other key pressed after CTRL-\ go to the underlying program.
util.nnoremap("<Leader>t", function()
  vim.cmd.new()         -- create new horizontal split window
  vim.cmd.terminal()
  vim.cmd.wincmd("J")   -- move current window to lowermost area
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert() -- go to Terminal-mode straight away
end)

-- ────────────────────────────────────────────────────────────────────────────
-- Quick escape to NORMAL mode from TERMINAL mode
-- ────────────────────────────────────────────────────────────────────────────
-- In TERMINAL-JOB mode (to which you get after "i" or "a" in TERMINAL mode) and
-- TERMINAL mode double tapping Escape key is akin to <CTRL-\> + <CTRL-n>
vim.keymap.set("t", "<Esc><Esc>","<C-\\><C-n>")

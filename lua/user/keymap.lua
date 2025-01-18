--==============================================================================
--  				keymap.lua
--  			Custom keymappings for neovim
--==============================================================================
local util = require('user.util')

local normal_noremap = util.normal_noremap
local insert_noremap = util.insert_noremap
local visual_noremap = util.visual_noremap

-- Setup global LEADER key
vim.g.mapleader = ";"

-- Close window with ctrl-q
normal_noremap("<C-q>", "<C-w>q")

-- Ctrl-s to save in NORMAL & INSERT modes, and return to relevant mode
normal_noremap("<C-s>", "<Cmd>update<CR>", { desc = "write buffer if modified" })
insert_noremap("<C-s>", "<Esc><Cmd>update<CR>a", { desc = "write buffer if modified" })

-- Easy navigation between splits
normal_noremap("<C-l>", "<C-w>l") --> Goto split on left
normal_noremap("<C-h>", "<C-w>h") --> Goto split on right
normal_noremap("<C-j>", "<C-w>j") --> Goto split below
normal_noremap("<C-k>", "<C-w>k") --> Goto split above

-- Transform a horizontal split to a vertical split (e.g. help pages)
-- NOTE: Assumes command is launched from a vertical split below first window
normal_noremap("<Leader>hv", "<C-w>t<C-w>H<C-w>l")
-- Transform a vertical split to a horizontal split
-- NOTE: Assumes command is run from a horizontal split to right of first one
normal_noremap("<Leader>vh", "<C-w>t<C-w>K<C-w>j")

-- Clear currently highlighted text with <Escape> key
normal_noremap("<Esc>", "<cmd>nohlsearch<Bar>:echo<CR>")

-- Source current buffer
normal_noremap("<M-s>", "<cmd>source %<cr>", { desc = "Source current file" })
visual_noremap("<M-s>", 'y<cmd>@"<cr>', { desc = "Source visual selection" })

-- In INSERT mode;
-- <C-u> deletes everything from cursor to the start of the line (UNDO LINE)
-- <C-w> deletes the word before the cursor (UNDO WORD),
insert_noremap("<C-l>", "<Esc>viwUea") -- Captalize previous WORD

-- Map ":" in NORMAL mode to open a command-line window ready for work
-- nnoremap(":", "q:i")
normal_noremap("<C-c>", "<cmd>tabclose<cr>")
normal_noremap("gn", "<cmd>tabnext<cr>")     -- by default "gT"
normal_noremap("gp", "<cmd>tabprevious<cr>") -- by default "gT"

-- Go up/down the page, keeping cursor in the middle of the screen
-- credit to Primeagen
normal_noremap("<C-d>", "<C-d>zz")
normal_noremap("<C-u>", "<C-u>zz")

-- From "nvim-lua/kickstart.nvim"
-- Make j/k move up/down using "visual" lines instead of actual lines, even when
-- lines are wrapped with window splitting, when motion is not prepended by a
-- count (e.g. k, not with 10k). Uses gk/gj instead of k/j, respectively, when
-- a line count is not given.
normal_noremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
normal_noremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

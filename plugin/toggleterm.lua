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
local function launch_toggle_term()
  vim.cmd.new()         -- create new horizontal split window
  vim.cmd.terminal()
  vim.cmd.wincmd("J")   -- move current window to lowermost area
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert() -- go to Terminal-mode straight away
end

vim.keymap.set("n", "<Plug>(LaunchToggleTerm)", launch_toggle_term,
  { desc="Toggle terminal window below editing window" })

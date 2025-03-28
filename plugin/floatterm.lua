--==============================================================================
--  				floatterm.lua
--  		        Toggable floating terminal
--==============================================================================
-- Custom plugin to launch a floating terminal that can be toggled on & off
-- Terminal will be 80% of height and 80% of width of the editor.

-- Track buffer ID and window ID (initiliaze to invalid values)
local state = {
  floating = {
    win = -1,
    buf = -1,
  }
}

-- Takes an optional table parameter `opt`
-- opts table can have following keys:
-- * width: number of columns
-- * height: number of rows
-- * buf: buffer ID
local RELATIVE_WIDTH = 0.8
local RELATIVE_HEIGHT = 0.8
local function create_floating_terminal(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * RELATIVE_WIDTH)
  local height = opts.height or math.floor(vim.o.lines * RELATIVE_HEIGHT)
  local luc_col = math.floor((vim.o.columns - width) / 2)
  local luc_row = math.floor((vim.o.lines - height) / 2)

  -- create a scratch buffer (scratch=true) that is not inserted to list of
  -- buffers (listed=false) if it does not already exist. If it does, reuse it
  -- NB: vim doesn't ask for a name for a scratch buffer when quiting
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  local config = {
    relative = "editor", -- position relative to editor grid
    width = width,
    height = height,
    col = luc_col,
    row = luc_row,
    border = "rounded",
    style = "minimal",
  }
  -- create a new "viewport" (window) into buffer (buf) and enter the window
  -- immediately (i.e. make it current window)
  local win = vim.api.nvim_open_win(buf, true, config)
  return { buf = buf, win = win }
end

-- Open a terminal buffer in a floating window if in NORMAL mode. If terminal
-- buffer has been created in previous invocations, re-use it. If in TERMINAL
-- mode, hide (close window preserving terminal buffer) the floating terminal.
-- Ensure cursor is at the end of terminal prompt when entering terminal buffer.
local function toggle_floating_terminal()
  -- if window exists close it, if it doesn't create a new window
  if vim.api.nvim_win_is_valid(state.floating.win) then
    -- close window without closing buffer (unlike nvim_win_close())
    vim.api.nvim_win_hide(state.floating.win)
  else
    state.floating = create_floating_terminal(state.floating)
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  end
  if vim.bo.buftype == "terminal" then
    -- position cursor at end of terminal prompt:
    vim.api.nvim_input("a")
  end
end

-- ALT-t toggles/untoggles a floating window
vim.keymap.set({ "n", "t" }, "<M-t>", toggle_floating_terminal, { desc = "Launch/hide floating window" })

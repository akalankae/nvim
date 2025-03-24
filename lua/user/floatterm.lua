--==============================================================================
--  				floatterm.lua
--  		        Toggable floating terminal
--==============================================================================

-- Create a floating terminal
local state = {
  floating = {
    win = -1,
    buf = -1,
  }
}

local function create_floating_terminal(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local luc_col = math.floor((vim.o.columns - width) / 2)
  local luc_row = math.floor((vim.o.lines - height) / 2)

  -- create a scratch buffer (scratch=true) that is not inserted to list of
  -- buffers (listed=false) if it does not already exist, if it does reuse it
  -- NB: vim doesn't ask for a name for a scratch buffer when quiting
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  local config = {
    relative = "editor",
    width = width,
    height = height,
    col = luc_col,
    row = luc_row,
    border = "double",
    style = "minimal",
  }
  local win = vim.api.nvim_open_win(buf, true, config)
  return { buf = buf, win = win }
end

vim.api.nvim_create_user_command(
  "Floatterm",
  function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
      vim.api.nvim_win_hide(state.floating.win)
    else
      state.floating = create_floating_terminal(state.floating)
    end
    vim.print(state)
  end,
  {}
)

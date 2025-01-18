-- Create a new buffer without file association
local buf = vim.api.nvim_create_buf(false, true)

-- Add some content to the buffer
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
  "Hello, this is a floating window!",
  "You can customize its size and style."
})

-- Define the size and position of the floating window
local width = 40
local height = 10
local opts = {
  relative = "editor",  -- Position relative to the editor
  width = width,
  height = height,
  col = (vim.o.columns - width) / 2,  -- Center the window horizontally
  row = (vim.o.lines - height) / 2,   -- Center the window vertically
  style = "minimal",   -- No borders or scrollbars
}

-- Open the floating window
vim.keymap.set("n", "<A-t>", function()
	vim.api.nvim_open_win(buf, true, opts)
	end, 
    { desc="open floating terminal"} )

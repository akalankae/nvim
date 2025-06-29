-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
--                          settings.lua
--                      Global settings for neovim
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local defaults = {
  tabstop = 8,      -- if document has '\t' chars, show each as N spaces
  expandtab = true, -- no new '\t' characters inserted (space only)
  softtabstop = 4,  -- pressing TAB or BACKSPACE makes cursor move N spaces
  shiftwidth = 4,   -- number of spaces used for (auto)indentation

  number = true,
  wrap = true,         -- long text wraps off right edge to next line

  signcolumn = "auto", -- hide signcolumn where possible
  cmdheight = 2,       -- increase commandline height

  ignorecase = true,
  smartcase = true,
  undofile = true,
  undodir = os.getenv("HOME") .. "/.vim/undodir",

  mouse = "a",
  cursorline = true, -- highlight line cursor is on
  splitright = true, -- split new windows to right of opened window
  splitbelow = true, -- split new windows below opened window
  dictionary = "/usr/share/dict/allwords.txt",
  clipboard = "unnamedplus",

  termguicolors = vim.fn.has("termguicolors") == 1,
  completeopt = { "menu", "menuone", "noselect" },

  include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=],
  includeexpr = "v:lua.FindRequiredPath(v:fname)",

}

for key, value in pairs(defaults) do
  vim.opt[key] = value
end

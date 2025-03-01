--=============================================================================
-- 				settings.lua
-- 			User settings for neovim
--=============================================================================

local settings = {
  expandtab = true, -- space replaces tab
  softtabstop = 4,  -- number of spaces tab/backspace make cursor move
  shiftwidth = 4,   -- number of spaces used for indentation

  number = true,
  textwidth = 80,      -- max line length is 80
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

  termguicolors = vim.fn.has("termguicolors") and true or false,
  completeopt = { "menu", "menuone", "noselect" },

}

for key, value in pairs(settings) do
  vim.opt[key] = value
end

vim.opt.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt.includeexpr = "v:lua.FindRequiredPath(v:fname)"

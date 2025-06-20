--=============================================================================
-- 				settings.lua
-- 			User settings for neovim
--=============================================================================

local defaults = {
  tabstop = 8,      -- if document has '\t' chars, show each as N spaces
  expandtab = true, -- no new '\t' characters inserted (space only)
  softtabstop = 4,  -- pressing TAB or BACKSPACE makes cursor move N spaces
  shiftwidth = 4,   -- number of spaces used for (auto)indentation

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

  termguicolors = vim.fn.has("termguicolors") == 1,
  completeopt = { "menu", "menuone", "noselect" },

  include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=],
  includeexpr = "v:lua.FindRequiredPath(v:fname)",

}

for key, value in pairs(defaults) do
  vim.opt[key] = value
end

-- NOTES: pls see following code
--
-- local fmt = string.format
--
-- -- Iterator that splits a string o a given delimiter
-- local function split(str, delim)
--   delim = delim or "%s"
--   return string.gmatch(str, fmt('[^%s]+', delim))
-- end
--
-- -- Find the proper directory separator depending
-- -- on lua installation or OS.
-- local function dir_separator()
--   -- Look at package.config for directory separator string (it's the first line)
--   if package.config then
--     return string.match(package.config, '^[^\n]')
--   elseif vim.fn.has('win32') == 1 then
--     return '\\'
--   else
--     return '/'
--   end
-- end
--
-- -- Search for lua traditional include paths.
-- -- This mimics how require internally works.
-- local function include_paths(fname, ext)
--   ext = ext or "lua"
--   local sep = dir_separator()
--   local paths = string.gsub(package.path, '%?', fname)
--   for path in split(paths, "%;") do
--     if vim.fn.filereadable(path) == 1 then
--       return path
--     end
--   end
-- end
--
-- -- Search for nvim lua include paths
-- local function include_rtpaths(fname, ext)
--   ext = ext or "lua"
--   local sep = dir_separator()
--   local rtpaths = vim.api.nvim_list_runtime_paths()
--   local modfile, initfile = fmt('%s.%s', fname, ext), fmt('init.%s', ext)
--   for _, path in ipairs(rtpaths) do
--     -- Look on runtime path for 'lua/*.lua' files
--     local path1 = table.concat({path, ext, modfile}, sep)
--     if     vim.fn.filereadable(path1) == 1 then
--       return path1
--     end
--     -- Look on runtime path for 'lua/*/init.lua' files
--     local path2 = table.concat({path, ext, fname, initfile}, sep)
--     if vim.fn.filereadable(path2) == 1 then
--       return path2
--     end
--   end
-- end
--
-- -- Global function that searches the path for the required file
-- function find_required_path(module)
--   -- Look at package.config for directory separator string (it's the first line)
--   local sep = string.match(package.config, '^[^\n]')
--   -- Properly change '.' to separator (probably '/' on *nix and '\' on Windows)
--   local fname = vim.fn.substitute(module, "\\.", sep, "g")
--   local f
--   ---- First search for lua modules
--   f = include_paths(fname, 'lua')
--   if f then return f end
--   -- This part is just for nvim modules
--   f = include_rtpaths(fname, 'lua')
--   if f then return f end
--   ---- Now search for Fennel modules
--   f = include_paths(fname, 'fnl')
--   if f then return f end
--   -- This part is just for nvim modules
--   f = include_rtpaths(fname, 'fnl')
--   if f then return f end
-- end
--
--
-- -- Set options to open require with gf
-- vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
-- vim.opt_local.includeexpr = "v:lua.find_required_path(v:fname)"

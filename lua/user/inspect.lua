-- Investigate runtimepath and packpath
local function str2table(s)
  local t = {}
  for sub in s:gmatch("[^,]+") do
    table.insert(t, sub)
  end
  return t
end

local packpath = str2table(vim.o.packpath)
local rtp = str2table(vim.o.runtimepath)

print("Runtimepath has " .. #packpath .. " dirs")
print("Packpath has " .. #rtp .. " dirs")

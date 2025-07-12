
-- List all keys in package.loaded table. This contains all modules imported by
-- `require MODULE` statements. (And other publicly visible names?)
local packages = vim.tbl_keys(package.loaded)
table.sort(packages)
print("List of loaded packages:")
for i, key in ipairs(packages) do
  print(i, key)
end
print("\n")

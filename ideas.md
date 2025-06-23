# Ideas for upgrading configuration

## LspAttached to explore LSP server

You may use data lsp server data to configure attached servers.
You can use an autocommand like below to get capabilities of lsp server.

_lua_
```
-- Inspecting LspAttach event for upgrading config to v0.11
create_autocmd("LspAttach", {
  callback = function(ev)
    vim.schedule(function()
      local lsp_server = vim.lsp.get_client_by_id(ev.data.client_id) or { name = "<unknown LSP server>" }
      local log_level = vim.log.levels.INFO
      vim.notify(lsp_server.name .. " attached", log_level) -- server name
      vim.tbl_map(print, vim.tbl_keys(lsp_server.server_capabilities)) -- capabilities
    end)
  end,
  desc = "Announce LSP server attachment"
})
```

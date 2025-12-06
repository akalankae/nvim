vim.lsp.enable({ "lua_ls", "basedpyright", "clangd", "bashls" })


-- Code formatting by attached LSP servers
-- When multiple LSP servers are attached that have the capability of document
-- formatting, there is a conflict when format-on-save autocommand is registered
-- by each LSP server's `on_attach` function. Solution to this is to register one
-- global format-on-save autocommand giving the option for the user to choose
-- from the list of available LSP servers to format.

function _G.FormatOnSave()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/formatting"
  })
  if #clients == 0 then
    vim.schedule(function()
      vim.notify(string.format("No formatters detected for %s (buffer %d)", filename, bufnr),
        vim.log.levels.INFO)
    end)
    return
  elseif #clients == 1 then
    vim.lsp.buf.format({
      filter = function(cli) return cli.id == clients[1].id end
    })
    vim.schedule(function()
      vim.notify(string.format("%s formatting %s (buffer %d)", clients[1].name, filename, bufnr),
        vim.log.levels.INFO)
    end)
  else
    local choices = {}
    for i, client in ipairs(clients) do
      table.insert(choices, string.format("%d. %s", i, client))
    end
    table.insert(choices, string.format("%d. %s", #choices + 1, "Cancel"))
    local choice = vim.fn.inputlist({
      "Multiple formatters available. Pick one:",
      unpack(choices)
    })
    if choice > 0 and choice <= #clients then
      local formatter = clients[choice]
      vim.lsp.buf.format({
        filter = function(cli) return cli.id == formatter.id end
      })
      vim.schedule(function()
        vim.notify(string.format("%s formatting %s (buffer %d)", formatter.name, filename, bufnr),
          vim.log.levels.INFO)
      end)
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("GlobalFormatOnSave", { clear = true }),
  callback = _G.FormatOnSave,
  desc = "Format on save with preferred language server"
})

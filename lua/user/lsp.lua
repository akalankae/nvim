vim.lsp.enable({ "lua_ls", "basedpyright", "clangd", "bashls" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) or {}
    if client ~= nil then
      vim.schedule(function()
        vim.notify(string.format("%s server attached to file %s opened in buffer %d\n",
          client.name, args.match, args.buf))
      end)
    end
  end
})

-- Code formatting by attached LSP servers
-- When multiple LSP servers are attached that have the capability of document
-- formatting, there is a conflict when format-on-save autocommand is registered
-- by each LSP server's `on_attach` function. Solution to this is to register one
-- global format-on-save autocommand giving the option for the user to choose
-- from the list of available LSP servers to format.

local log_level = vim.log.levels.INFO

local function format_on_save()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/formatting"
  })
  if #clients == 0 then
    vim.schedule(function()
      vim.notify(string.format("No formatters detected for %s (buffer %d)", filename, bufnr), log_level)
    end)
    return
  elseif #clients == 1 then
    vim.lsp.buf.format({
      filter = function(cli) return cli.id == clients[1].id end
    })
    vim.schedule(function()
      vim.notify(string.format("%s formatting %s (buffer %d)", clients[1].name, filename, bufnr),
        log_level)
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
          log_level)
      end)
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("GlobalFormatOnSave", { clear = true }),
  callback = format_on_save,
  desc = "Format on save with preferred language server"
})

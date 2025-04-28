--============================================================================
--                          LSP Config
--============================================================================

-- Refer each server home page to look up available settings
-- NOTE: each of the tables in `server_settings` have `capabilities` and
-- `on_attach` keys that can be used for autocompletion

-- Function to call when `client` (LSP server) attaches to a buffer. i.e.
-- when `LspAttach` event is triggered.
local on_attach = function(client, bufnr)
  if client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
    vim.schedule(function()
      vim.notify("Hover provider capability disabled for " .. client.name, vim.log.levels.INFO)
    end)
  end
end

local server_settings = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          enable = true,
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          maxPreload = 2000,
          preloadFileSize = 50000,
          library = { vim.env.VIMRUNTIME },
        },
        telemetry = false,
        callSnippet = "Replace",
        format = {
          enable = true,
          defaultConfig = { quote_style = "double", trailing_tab_separator = "smart" },
        },
      },
    },
  },
  -- Alternates: "jedi_language_server", "pylsp", "pyright"
  basedpyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
        }
      }
    },
    flags = {
      debounce_text_changes = 150,
    }
  },
  -- Needs python-lsp-server, python-lsp-black (arch packages) installed
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pycodestyle = { enabled = false },
  --         yapf = { enabled = false },
  --         autopep8 = { enabled = false },
  --         black = {
  --           enabled = true,
  --           line_length = 80
  --         },
  --       }
  --     }
  --   }
  -- },
  ruff = {
    -- on_attach: `hoverProvider` capability is manually disabled
  },
  clangd = {
    offsetEncoding = "utf-16"
  },
  bashls = {
    filetypes = { "bash", "sh" }, -- this is default
  },
  -- Odin language serer at https://github.com/DanielGavin/ols.git
  -- I have forked this repo to my account. Running build.sh installs ols on
  -- root of the project. (same for odinfmt.sh for formatting)
  -- `cmd` key points to this executable.
  ols = {
    init_options = {
      checker_args = "-strict-style",
      collections = {
        { name = "shared", path = vim.fn.expand("$HOME/odin-lib") }
      },
    },
    cmd = { vim.fn.expand("$HOME/git/ols/ols") },
    formatting = {
      command = { vim.fn.expand("$HOME/git/ols/odinfmt"), "-stdin" },
    }
  },
  gopls = {
    cmd = { "gopls", "serve" }, -- `serve`: run a LSP server for go
    settings = {
      gopls = {
        gofumpt = true, -- enable gofumpt (for formatting)
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        -- formatting = {
          -- gofumpt = true, -- use gofumpt rules for formatting
          -- goimports = true,
        -- }
      }
    }
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- putting `keys` to this table as a key breaks things so that Lsp<...> commands nvim-lspconfig adds are not loaded
      -- so, ensure keys are mapped before the plugin is loaded
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" }) -- default: go to local definition
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" })
      vim.keymap.set("n", "gR", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
      vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame symbol under cursor" })
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
    end,
    config = function()
      vim.diagnostic.config({
        -- Use icons for diganostic signs (instead of letters)
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
          }
        },
        severity_sort = true,
        update_in_insert = false,
        underline = true,
        virtual_text = {
          source = "if_many", -- if multiple diagnostics
        },
      })
      local lspconfig = require "lspconfig"
      for server, settings in pairs(server_settings) do
        settings.on_attach = on_attach
        lspconfig[server].setup(settings)
      end
    end,
  }
}

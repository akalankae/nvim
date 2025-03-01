--============================================================================
--                          DAP Config
--============================================================================
-- Relavent debug adapters need to be manually installed, this config is not
-- concerned with this.
-- List of DAP adapters:
-- 1. LUA:
--  (a) local-lua-debug-vscode (arch package ends with "-git")
--  (b) nlua (for debugging neovim's lua plugins)
-- 2. PYTHON: debugpy (python module)
-- 3. C: gdb
--
-- TODO: This is a work in progress!


return {
  -- Enable Neovim to speak Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {
          auto_close = false,
        },
        config = function(_, opts)
          opts = opts or {}
          require("dapui").setup(opts)
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- for versions <= 0.10
        opts = {},
      },
    },

    -- Debugging keymap
    keys = {
      {
        "<F2>",
        function() require("dap").continue() end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F3>",
        function() require("dap").step_over() end,
        desc = "Debug: Step Over",
      },
      {
        "<F4>",
        function() require("dap").step_into() end,
        desc = "Debug: Step Into",
      },
      {
        "<F5>",
        function() require("dap").step_out() end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F6>",
        function() require("dapui").toggle() end,
        desc = "DapUI: See Last Session Result",
      },
      {
        "<SPACE>b",
        function() require("dap").toggle_breakpoint() end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<SPACE>B",
        function()
          require("dap").set_breakpoint(vim.fn.input "Set Breakpoint Condition")
        end,
        desc = "Debug: Set Breakpoint",
      },
      {
        "<SPACE>C",
        function() require("dap").run_to_cursor() end,
        desc = "Debug: Run to Cursor",
      },
      {
        "<SPACE>R",
        function() require("dap").restart() end,
        desc = "Debug: Restart debugging session",
      },
    },

    config = function(_)
      local dap = require "dap"
      local ui  = require "dapui"

      dap.set_log_level("DEBUG") -- TODO: remove this (this is for debugging)

      ------------------------------------------------------------------------
      -- LUA
      ------------------------------------------------------------------------
      -- adapter path: /usr/bin/local-lua-dbg is a script launched with node
      dap.adapters.lua = {
        type = "executable",
        command = "/usr/bin/local-lua-dbg",
        args = {},
      }

      dap.adapters.nlua = function(callback, config)
        callback({
          type = "server",
          host = config.host or "127.0.0.1",
          port = config.port or 8086,
        })
      end

      dap.configurations.lua = {
        -- for vanilla lua
        {
          type = "lua",
          request = "launch",
          name = "Debug: Launch lua file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        -- for neovim's lua (e.g. debugging lua plugins)
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
        },
      }
      ------------------------------------------------------------------------
      -- C
      ------------------------------------------------------------------------
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Select and attach to process",
          type = "gdb",
          request = "attach",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          pid = function()
            local name = vim.fn.input("Executable name (filter): ")
            return require("dap.utils").pick_process({ filter = name })
          end,
          cwd = "${workspaceFolder}"
        },
        {
          name = "Attach to gdbserver :1234",
          type = "gdb",
          request = "attach",
          target = "localhost:1234",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}"
        },
      }

      ------------------------------------------------------------------------
      -- Python
      ------------------------------------------------------------------------
      dap.adapters.python = function(callback, config)
        if config.request == "attach" then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or "127.0.0.1"
          callback({
            type = "server",
            port = assert(port, "`connect.port` is required for a python attach configuration"),
            host = host,
            options = { source_filetype = "python" },
          })
        else
          callback({
            type = "executable",
            command = (os.getenv("VIRTUAL_ENV") or "/usr") .. "/bin/python", -- path from virtualenv
            args = { "-m", "debugpy.adapter" },
            options = { source_filetype = "python" },
          })
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug: Launch file",

          -- following options are for debugpy
          program = "${file}",
          pythonPath = function()
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
              return venv .. "/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function() ui.open() end
      dap.listeners.before.event_terminated["dapui_config "] = function() ui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() ui.close() end
      dap.listeners.before.attach["dapui_config"] = function() ui.open() end
      dap.listeners.before.launch["dapui_config"] = function() ui.open() end
    end,
  },
  -- One Small Step for Vimkind: Debug Adapter for Neovim
  {
    "jbyuki/one-small-step-for-vimkind",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    keys = {
      {
        "<SPACE>O",
        function() require("osv").launch({ port = 8086 }) end,
        desc = "Debug(OSV): Launch server in Debugee",
      },
      {
        "<SPACE>w",
        function() require("dap.ui.widgets").hover() end,
        desc = "Debug(OSV): Widgets Hover",
      },
      {
        "<SPACE>c",
        function()
          local widgets = require "dap.ui.widgets"
          widgets.centered_float(widgets.frames)
        end,
      },
    },
  },
}

-- Debugger configuration.
-- This follows the same shape as LazyVim and AstroNvim:
-- - nvim-dap is the debugger client
-- - mason-nvim-dap connects Mason-installed debug adapters to nvim-dap
-- - nvim-dap-ui gives us debugger panels for scopes, stacks, watches, and REPL
-- - nvim-dap-virtual-text shows variable values inline while debugging
-- - nvim-dap-go provides Go/Delve defaults so we do not write the adapter by hand

-- Ask for runtime arguments before launching a debug session.
-- LazyVim uses this idea so the same debug config can run with different args.
local function get_args(config)
  local args = type(config.args) == "function" and config.args() or config.args or {}
  local args_string = type(args) == "table" and table.concat(args, " ") or args

  config = vim.deepcopy(config)

  config.args = function()
    local input = vim.fn.input("Run with args: ", args_string)

    return require("dap.utils").splitstr(vim.fn.expand(input))
  end

  return config
end

-- Show a short, actionable message about Go debugging prerequisites.
-- This is faster than discovering a missing Delve install only after trying to
-- start a debug session.
local function check_go_debugger()
  if vim.fn.executable("dlv") == 1 then
    vim.notify("Delve is available: Go debugging can run.", vim.log.levels.INFO)
    return
  end

  vim.notify(
    table.concat({
      "Delve (`dlv`) is not on PATH.",
      "Install it with `:MasonInstall delve` after fixing the local Go toolchain.",
      "Current blocker seen earlier: Go stdlib/tool version mismatch.",
    }, "\n"),
    vim.log.levels.WARN
  )
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Debugger sidebars and floating evaluation windows.
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
      },

      -- Inline values while a debug session is stopped.
      "theHamsta/nvim-dap-virtual-text",

      -- Mason bridge for installing and configuring debug adapters.
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
          "mason-org/mason.nvim",
        },
      },

      -- Go extension for nvim-dap. It knows how to launch Delve and debug tests.
      "leoluz/nvim-dap-go",
    },
    keys = {
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Breakpoint condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Run or continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue({ before = get_args })
        end,
        desc = "Run with args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to cursor",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Session",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        mode = { "n", "x" },
        desc = "Evaluate expression",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Debug widgets",
      },
      {
        "<leader>d?",
        function()
          require("dap.ui.widgets").preview()
        end,
        desc = "Preview debug value",
      },
      { "<leader>dG", check_go_debugger, ft = "go", desc = "Check Go debugger" },
      {
        "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        ft = "go",
        desc = "Debug Go test",
      },
      {
        "<leader>dgl",
        function()
          require("dap-go").debug_last_test()
        end,
        ft = "go",
        desc = "Debug last Go test",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configure Mason's DAP bridge after nvim-dap is loaded, matching the
      -- ordering used by LazyVim and recommended by mason-nvim-dap.
      require("mason-nvim-dap").setup({
        -- We keep Mason's DAP bridge enabled, but do not force-install Delve
        -- here. Delve is a Go-built tool, so a broken local Go toolchain would
        -- make Neovim repeatedly show install errors on startup. Install it with
        -- :MasonInstall delve after `go version` and `go env GOROOT` agree.
        ensure_installed = {},

        -- Keep adapter installation explicit instead of installing every
        -- debugger for every configured filetype.
        automatic_installation = false,

        -- Empty handlers asks mason-nvim-dap to use its default adapter setup.
        handlers = {},
      })

      dapui.setup({
        -- Keep the debugger layout predictable: variables and stack on the
        -- left, console/repl at the bottom.
        layouts = {
          {
            position = "left",
            size = 40,
            elements = {
              { id = "scopes", size = 0.45 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.10 },
            },
          },
          {
            position = "bottom",
            size = 10,
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
          },
        },

        floating = {
          border = "rounded",
        },
      })
      require("nvim-dap-virtual-text").setup({})
      require("dap-go").setup({
        delve = {
          -- nvim-dap-go uses this executable when launching Go debug sessions.
          -- Mason will place `dlv` on Neovim's PATH once Delve is installed.
          path = "dlv",
        },
      })

      -- Use simple ASCII signs to stay portable across terminals and fonts.
      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticInfo", linehl = "DapStoppedLine" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticError" })

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- Open the debugger UI when a session starts and close it when the
      -- session exits. AstroNvim uses this same workflow.
      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open({})
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close({})
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close({})
      end
    end,
  },
}

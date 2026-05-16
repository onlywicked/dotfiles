-- Snacks debugging helpers.
-- Useful while learning Lua and configuring Neovim.

return {
  {
    "folke/snacks.nvim",

    init = function()
      -- Pretty-print Lua values in a notification popup.
      -- Example:
      --   :lua dd(vim.bo)
      _G.dd = function(...)
        require("snacks").debug.inspect(...)
      end

      -- Show a Lua backtrace.
      -- Useful when errors do not clearly show where they came from.
      _G.bt = function()
        require("snacks").debug.backtrace()
      end

      -- Improve Neovim's built-in print display.
      if vim.fn.has("nvim-0.11") == 1 then
        vim._print = function(_, ...)
          dd(...)
        end
      else
        vim.print = dd
      end
    end,

    keys = {
      {
        "<leader>xr",
        function()
          require("snacks").debug.run()
        end,
        mode = { "n", "x" },
        desc = "Run Lua buffer or selection",
      },

      {
        "<leader>xb",
        function()
          require("snacks").debug.backtrace()
        end,
        desc = "Show Lua backtrace",
      },

      {
        "<leader>xm",
        function()
          require("snacks").debug.metrics()
        end,
        desc = "Show Lua memory metrics",
      },
    },
  },
}

return {
  {
    "folke/snacks.nvim",

    -- Load Snacks immediately during startup.
    -- Many utility modules (input/notifier/etc.) are useful globally.
    priority = 1000,
    lazy = false,

    opts = {
      -- Keep Snacks Explorer disabled.
      -- We still use Snacks for picker, indent guides, notifications, and Lua
      -- debugging helpers, but the file explorer sidebar is intentionally off.
      explorer = {
        enabled = false,
      },

      -- Better vim.ui.input().
      input = {
        enabled = true,
      },

      -- Pretty notifications.
      notifier = {
        enabled = true,
      },

      -- Faster opening of very small files.
      quickfile = {
        enabled = true,
      },

      -- Protect Neovim from freezing on huge files.
      bigfile = {
        enabled = true,
      },
    },
  },
}

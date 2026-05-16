return {
  {
    "folke/snacks.nvim",

    -- Load Snacks immediately during startup.
    -- Many utility modules (input/notifier/etc.) are useful globally.
    priority = 1000,
    lazy = false,

    opts = {
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

-- Small quality of life plugins. (Not necessary but I forget sometimes)
-- These are low-cost helpers to improve the experience.
-- I took it from AstroNvim

return {
  -- Shows a popup of available keymaps.
  -- We keep it manual-only so it does not appear every time you pause after a
  -- prefix key.
  {
    "folke/which-key.nvim",
    lazy = false,

    keys = {
      {
        "<leader>w",
        function()
          require("which-key").show({
            keys = "<leader>",
            mode = "n",
          })
        end,
        desc = "Show keymaps",
      },
    },

    opts = {
      -- Disable automatic triggers.
      -- which-key currently expects an internal `triggers.modes` table to
      -- exist, so an empty trigger list can crash when calling `show()`.
      -- This harmless placeholder keeps that internal shape valid without
      -- making which-key appear after normal prefix keys.
      triggers = {
        { "<Ignore>", mode = "n" },
      },
    },
  },

  -- Detects indentation style from the current file.
  -- This helps when opening projects that use tabs, 2 spaces, or 4 spaces.
  {
    "NMAC427/guess-indent.nvim",
    event = "BufReadPre",

    opts = {},
  },

  -- Shows LSP progress notifications.
  -- Useful when language servers are indexing, analyzing, or formatting.
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",

    opts = {},
  },
}

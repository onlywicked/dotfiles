-- Small quality of life plugins. (Not necessary but I forget sometimes)
-- These are low-cost helpers to improve the experience.
-- I took it from AstroNvim

return {
  -- Shows a popu of available keymaps after pressing a prefix key.
  -- Example: pressing <leader> waits briefly, then shows matching mappings.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      delay = 500,
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

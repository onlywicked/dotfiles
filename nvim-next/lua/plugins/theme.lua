-- Theme configuration.

return {
  "catppuccin/nvim",
  name = "catppuccin",

  -- Load the theme early so other plugins can use its highlight groups.
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,

      integrations = {
        native_lsp = {
          enabled = true,
        },
        treesitter = true,
      },
    })

    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}

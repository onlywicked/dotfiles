-- Formatting configuration.
-- conform.nvim runs external formatters such as gofumpt and oxfmt.
--
-- Formatting is separate from LSP on purpose. Language servers can format, but
-- dedicated formatters are often more predictable and easier to standardize
-- across projects.

return {
  -- Formatter runner.
  -- It chooses a formatter from `formatters_by_ft` based on the current
  -- buffer's filetype and can fall back to LSP formatting when needed.
  {
    "stevearc/conform.nvim",
    event = {
      "BufWritePre",
    },
    cmd = {
      "ConformInfo",
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({
            async = true,
            lsp_fallback = true,
          })
        end,
        mode = { "n", "v" },
        desc = "Format file",
      },
    },
    opts = {
      -- Formatters are mapped by Neovim filetype.
      -- Check the current buffer's filetype with `:set filetype?`.
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },

        javascript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },

        css = { "oxfmt" },
        html = { "oxfmt" },
        json = { "oxfmt" },
        jsonc = { "oxfmt" },
        markdown = { "oxfmt" },
        yaml = { "oxfmt" },

        lua = { "stylua" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
      },

      -- Format automatically before saving.
      -- lsp_fallback keeps formatting available for filetypes without an
      -- external formatter in the table above.
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    },
  },
}

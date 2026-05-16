-- External tool installer.
-- LSP servers are installed by mason-lspconfig in lsp.lua. Other tools such as
-- formatters, linters, and debuggers are normal Mason packages, so they are
-- installed here with mason-tool-installer.

return {
  -- Installs Mason packages that are not language servers.
  -- These tools are used by formatters, linters, and debuggers configured in
  -- separate plugin files.
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "golangci-lint",
        "oxlint",
        "oxfmt",
        "shellcheck",
        "stylua",
      },

      auto_update = false,
      run_on_start = true,
    },
  },
}

-- Linting configuration.
-- nvim-lint runs external linters and publishes their results as Neovim
-- diagnostics. This complements LSP diagnostics; it does not replace LSP.

return {
  -- Asynchronous linter runner.
  -- Each filetype maps to one or more linter names from nvim-lint's registry.
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- Go projects often use golangci-lint as the project-level source of
        -- truth. It can be slower than gopls diagnostics, so we run it on save
        -- and when leaving insert mode rather than on every keystroke.
        go = { "golangcilint" },

        -- Oxlint is a fast JavaScript/TypeScript linter from the Oxc project.
        -- nvim-lint will prefer a project-local ./node_modules/.bin/oxlint when
        -- one exists, then fall back to the Mason-installed oxlint binary.
        javascript = { "oxlint" },
        javascriptreact = { "oxlint" },
        typescript = { "oxlint" },
        typescriptreact = { "oxlint" },

        -- ShellCheck catches common shell script problems that bashls may not.
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }

      local group = vim.api.nvim_create_augroup("UserLint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = group,
        desc = "Run linters for current buffer",
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, {
        desc = "Run lint",
      })
    end,
  },
}

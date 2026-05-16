-- Diagnostic display.
-- Diagnostics are errors, warnings, hints, and info messages produced by LSP
-- servers or linting tools.

vim.diagnostic.config({
  -- Show small symbols in the sign column.
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },

  -- Underline problematic code.
  underline = true,

  -- Do not update diagnostic while typing.
  -- Reduces visual churn.
  update_in_insert = false,

  -- Sort higher-severity diagnostics first.
  severity_sort = true,

  -- Show diagnostic text at the end of the line.
  -- We keep this off by default because it can make code noisy.
  virtual_text = false,

  -- Use bordered floating windows for diagnostic details.
  float = {
    border = "rounded",
    source = "if_many",
  },
})

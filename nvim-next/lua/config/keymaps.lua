-- Core keymaps.
-- These mappings do not require plugins.
-- Plugin mappings will live beside the plugin that provides the behavior.

local keymap = vim.keymap.set

-- Clear search highlights after using / or ?.
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", {
  desc = "Clear search highlight",
})

-- Move between split windows with Ctrl + direction
keymap("n", "<C-h>", "<C-w><C-h>", {
  desc = "Move to left window",
})

keymap("n", "<C-j>", "<C-w><C-j>", {
  desc = "Move to lower window",
})

keymap("n", "<C-k>", "<C-w><C-k>", {
  desc = "Move to upper window",
})

keymap("n", "<C-l>", "<C-w><C-l>", {
  desc = "Move to right window",
})

-- Use Esc twice to leave terminal mode.
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", {
  desc = "Exit terminal mode",
})

-- Move selected lines up and down while keeping the selection.
keymap("v", "J", ":m '>+1<CR>gv=gv", {
  desc = "Move selection down",
})

keymap("v", "K", ":m '<-2<CR>gv=gv", {
  desc = "Move selection up",
})

-- Show diagnostics and move between them.
keymap("n", "<leader>e", vim.diagnostic.open_float, {
  desc = "Show current line diagnostic",
})

keymap("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, {
  desc = "Show previous diagnostic",
})

keymap("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, {
  desc = "Show next diagnostic",
})

-- Send all diagnostics in the current buffer to the quickfix list.
keymap("n", "<leader>q", vim.diagnostic.setqflist, {
  desc = "Diagnostics quickfix list",
})

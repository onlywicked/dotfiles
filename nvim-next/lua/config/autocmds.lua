-- Autocommands.
-- Autocommands react to editor events such as yanking text, opening a file, or
-- saving a buffer.

local augroup = vim.api.nvim_create_augroup

-- Group names let us clear or replace autocommands safely.
local general = augroup("UserGeneral", { clear = true })

-- Briefly highlight text after yanking.
-- This gives visual feedback that yanking copied the intended text.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = general,
  desc = "Highlight yanked text",

  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to the last cursor position when reopening a file.
-- This skips git commit messages because they usually start at the top.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = general,
  desc = "Restore cursor position",

  callback = function(event)
    local exclude = { "gitcommit" }
    local filetype = vim.bo[event.buf].filetype

    if vim.tbl_contains(exclude, filetype) then
      return
    end

    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(event.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Resize splits when the terminal window size changes
vim.api.nvim_create_autocmd("VimResized", {
  group = general,
  desc = "Resize splits with window",
  command = "tabdo wincmd = ",
})

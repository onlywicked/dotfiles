-- Built-in file explorer configuration.
-- Netrw ships with Neovim, so this gives us a file browser without another
-- explorer plugin.

local keymap = vim.keymap.set
local global = vim.g

local function find_netrw_window()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].filetype == "netrw" then
      return win
    end
  end
end

local function open_netrw_right(path)
  -- Remember the editing window before opening netrw.
  -- Netrw uses this number when opening files from the explorer.
  global.netrw_chgwin = vim.fn.winnr()

  local command = "Vexplore"

  if path and path ~= "" then
    command = command .. " " .. vim.fn.fnameescape(path)
  end

  vim.cmd(command)
end

local function toggle_netrw_right()
  local netrw_win = find_netrw_window()

  if netrw_win then
    vim.api.nvim_win_close(netrw_win, false)
    return
  end

  open_netrw_right()
end

-- Hide the help banner at the top of netrw.
global.netrw_banner = 0

-- Use tree view.
-- 0 = thin list, 1 = long list, 2 = wide list, 3 = tree.
global.netrw_liststyle = 3

-- Open files from netrw in the current window.
-- The explorer itself opens vertically, but selected files replace the target
-- window instead of creating surprise splits.
global.netrw_browse_split = 0

-- Keep vertical explorer windows on the right.
-- This keeps your main editing layout stable because the explorer appears
-- after the current file window instead of pushing it to the right.
global.netrw_altv = 1

-- Width used by :Vexplore.
global.netrw_winsize = 25

-- Hide noisy files in the explorer.
-- Press `a` inside netrw to cycle hidden-file visibility when needed.
-- global.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

-- Keep directory deletion behavior explicit and recursive, matching your vimrc.
global.netrw_localrmdir = "rm -rf"

-- NERDTree-style toggle.
-- Your old vimrc used `<C-n>` for `:NERDTreeToggle`.
-- We do not use `:Lexplore` because it always forces the explorer to the left.
keymap("n", "<C-n>", toggle_netrw_right, {
  desc = "Toggle netrw",
})

-- Open netrw vertically by default.
keymap("n", "<leader>pv", open_netrw_right, {
  desc = "Open netrw vertical explorer",
})

-- Open netrw in the current window when you want a full-window browser.
keymap("n", "<leader>pV", "<cmd>Explore<CR>", {
  desc = "Open netrw current window",
})

-- Open netrw in a horizontal split.
keymap("n", "<leader>ps", "<cmd>Sexplore<CR>", {
  desc = "Open netrw horizontal split",
})

-- Open netrw at the directory of the current file.
keymap("n", "<leader>p.", function()
  open_netrw_right(vim.fn.expand("%:p:h"))
end, {
  desc = "Open current file directory in netrw",
})

-- Small netrw-only quality-of-life mappings.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function(event)
    -- Keep netrw buffers out of buffer lists.
    vim.bo[event.buf].buflisted = false

    -- Close the netrw buffer with q.
    keymap("n", "q", "<cmd>close<CR>", {
      buffer = event.buf,
      desc = "Close netrw",
    })

    -- NERDTree-style open mappings inside netrw.
    -- `i` opens the file under the cursor in a horizontal split.
    keymap("n", "i", function()
      vim.api.nvim_feedkeys("o", "m", false)
    end, {
      buffer = event.buf,
      desc = "Open in horizontal split",
    })

    -- `s` opens the file under the cursor in a vertical split.
    keymap("n", "s", function()
      vim.api.nvim_feedkeys("v", "m", false)
    end, {
      buffer = event.buf,
      desc = "Open in vertical split",
    })

    -- `t` opens the file under the cursor in a new tab.
    keymap("n", "t", function()
      vim.api.nvim_feedkeys("t", "m", false)
    end, {
      buffer = event.buf,
      desc = "Open in new tab",
    })
  end,
})

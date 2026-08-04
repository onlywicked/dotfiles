-- Git integration.
-- gitsigns.nvim shows added, changed, and deleted lines in the sign column.
-- It also gives us small Git hunk actions without adding a full Git UI.

return {
  {
    "lewis6991/gitsigns.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
      "BufWinEnter",
    },
    opts = {
      -- Use simple ASCII signs so the gutter looks correct even without a
      -- patched Nerd Font.
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },

      -- Keep staged signs enabled so you can tell unstaged and staged changes
      -- apart after using a hunk stage command.
      signs_staged_enable = true,

      -- Keep blame off by default. It is useful, but noisy when always visible.
      -- Toggle it with <leader>gtb when you want line blame.
      current_line_blame = false,

      -- Disable for very large files to avoid slowing down huge generated files.
      max_file_length = 40000,

      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = desc,
            silent = true,
          })
        end

        -- Move between changed Git hunks. If the window is already in Vim's
        -- diff mode, keep the built-in [c and ]c behavior.
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next Git hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Previous Git hunk")

        -- Stage or reset only the current hunk.
        map("n", "<leader>ghs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "<leader>ghr", gitsigns.reset_hunk, "Reset hunk")

        -- In visual mode, stage or reset the selected lines inside a hunk.
        map("v", "<leader>ghs", function()
          gitsigns.stage_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "Stage selected hunk")

        map("v", "<leader>ghr", function()
          gitsigns.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "Reset selected hunk")

        -- Buffer-wide hunk operations.
        map("n", "<leader>ghS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>ghR", gitsigns.reset_buffer, "Reset buffer")

        -- Inspect the current hunk without leaving the buffer.
        map("n", "<leader>ghp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>ghi", gitsigns.preview_hunk_inline, "Preview hunk inline")
        map("n", "<leader>ghb", function()
          gitsigns.blame_line({ full = true })
        end, "Blame line")

        -- Show a file diff against the index, or against the previous commit.
        map("n", "<leader>ghd", gitsigns.diffthis, "Diff this")
        map("n", "<leader>ghD", function()
          gitsigns.diffthis("~")
        end, "Diff this against HEAD~")

        -- Send Git hunks to quickfix. Lowercase is current buffer, uppercase is
        -- the whole repository.
        map("n", "<leader>ghq", gitsigns.setqflist, "Git hunks quickfix")
        map("n", "<leader>ghQ", function()
          gitsigns.setqflist("all")
        end, "Repository hunks quickfix")

        -- Toggles for optional Git overlays.
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, "Toggle Git blame")
        map("n", "<leader>gtw", gitsigns.toggle_word_diff, "Toggle Git word diff")

        -- Text object for selecting a Git hunk with `vih` or `dih`.
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git hunk")
      end,
    },
  },
}

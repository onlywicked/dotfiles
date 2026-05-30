-- Completion configuration.
-- blink.cmp provides the completion menu for LSP suggestions, filesystem paths,
-- snippets, and words from open buffers.
--
-- It replaces CoC's completion UI while keeping the same core goal: useful code
-- suggestions with minimal configuration.

local function has_words_before()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  local column = cursor[2]

  if column == 0 then
    return false
  end

  local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]

  return text:sub(column, column):match("%s") == nil
end

return {
  -- Fast completion engine with built-in LSP, path, snippets, and buffer
  -- sources. We pin to v1 releases because blink uses prebuilt fuzzy-matcher
  -- binaries on release tags.
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",

    -- Provides a broad set of community snippets. blink.cmp can load these
    -- through Neovim's native vim.snippet API, so we do not need LuaSnip yet.
    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      keymap = {
        -- Match the old CoC completion muscle memory from .vimrc:
        -- - <Tab> moves to the next completion item
        -- - <Tab> opens completion when there is text before the cursor
        -- - <Tab> inserts a real tab/indent when the cursor is after whitespace
        -- - <S-Tab> moves to the previous completion item
        -- - <CR> accepts the selected completion item
        preset = "enter",

        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end

            if has_words_before() then
              return cmp.show()
            end
          end,
          "fallback",
        },

        ["<S-Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_prev()
            end

            -- CoC used <C-h> when the menu was not visible.
            return vim.api.nvim_replace_termcodes("<C-h>", true, false, true)
          end,
        },
      },

      appearance = {
        -- Use plain mono Nerd Font icons when available.
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          -- Do not open documentation automatically on every completion item.
          -- Manual docs are less noisy while learning the completion menu.
          auto_show = false,
        },
      },

      sources = {
        -- Order matters. LSP is primary, then paths/snippets/buffer words fill
        -- in common editing gaps.
        default = { "lsp", "path", "snippets", "buffer" },
      },

      fuzzy = {
        -- Prefer the faster Rust matcher when the release binary is available.
        -- blink will warn if it has to fall back.
        implementation = "prefer_rust_with_warning",
      },
    },
  },
}

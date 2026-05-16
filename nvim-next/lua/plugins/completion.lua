-- Completion configuration.
-- blink.cmp provides the completion menu for LSP suggestions, filesystem paths,
-- snippets, and words from open buffers.
--
-- It replaces CoC's completion UI while keeping the same core goal: useful code
-- suggestions with minimal configuration.

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
      -- Use blink's default insert-mode mappings.
      -- This gives completion navigation/confirmation without custom key glue.
      keymap = {
        preset = "default",
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

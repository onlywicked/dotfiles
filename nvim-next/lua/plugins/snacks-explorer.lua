-- Snacks file explorer.
-- Snacks Explorer is a file explorer, but internally it is built on top of
-- Snacks Picker. That means some explorer-specific behavior is configured under
-- `picker.sources.explorer`.

return {
  {
    "folke/snacks.nvim",

    keys = {
      {
        "<leader>pe",
        function()
          require("snacks").explorer()
        end,
        desc = "Open file explorer",
      },

      {
        "<leader>pE",
        function()
          -- Open the explorer at your Neovim config directory.
          require("snacks").explorer({
            cwd = vim.fn.stdpath("config"),
          })
        end,
        desc = "Open config explorer",
      },
    },

    opts = {
      explorer = {
        enabled = true,

        -- Replace netrw.
        -- This makes Snacks Explorer open when you start Neovim with a directory:
        --   nvim .
        replace_netrw = true,
      },

      picker = {
        sources = {
          explorer = {
            -- Show files as a tree instead of a flat list.
            tree = true,

            -- Keep the explorer open after opening a file.
            -- Set this to true if you prefer the explorer to close automatically.
            auto_close = false,

            -- Focus the file list when the explorer opens.
            -- Use "input" if you prefer to start by typing a search.
            focus = "list",

            -- Follow the current file in the explorer.
            -- When you open a file, the explorer tries to reveal it.
            follow_file = true,

            -- Show hidden files such as `.gitignore`.
            hidden = true,

            -- Do not show files ignored by git, like node_modules.
            ignored = false,

            layout = {
              preset = "sidebar",

              layout = {
                position = "left",
                width = 30,
              },
            },
          },
        },
      },
    },
  },
}

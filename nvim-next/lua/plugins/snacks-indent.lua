-- Snacks indentation guides.
-- AstroNvim uses Snacks instead of indent-blankline.nvim.

return {
  {
    "folke/snacks.nvim",

    opts = {
      indent = {
        enabled = true,

        -- Normal indentation guide lines.
        indent = {
          char = "▏",
          hl = "UserIndentGuide",
        },

        -- Current scope guide.
        -- This changes color when the cursor is inside a block/function.
        scope = {
          char = "▏",
          hl = "UserIndentScope",
        },

        -- Disable animation because it becomes visual noise in nested code.
        animate = {
          enabled = false,
        },

        -- Disable indent guides in special buffers like help, terminals, etc.
        filter = function(bufnr)
          return vim.bo[bufnr].buftype == ""
            and vim.g.snacks_indent ~= false
            and vim.b[bufnr].snacks_indent ~= false
        end,
      },

      -- Scope detection can use Treesitter when available.
      scope = {
        enabled = true,

        filter = function(bufnr)
          return vim.bo[bufnr].buftype == ""
            and vim.g.snacks_scope ~= false
            and vim.b[bufnr].snacks_scope ~= false
        end,
      },
    },

    config = function(_, opts)
      -- Catppuccin-friendly colors.
      vim.api.nvim_set_hl(0, "UserIndentGuide", { fg = "#45475a" })
      vim.api.nvim_set_hl(0, "UserIndentScope", { fg = "#cba6f7" })

      require("snacks").setup(opts)

      -- Toggle indentation guides manually.
      vim.keymap.set("n", "<leader>u|", function()
        require("snacks").toggle.indent():toggle()
      end, {
        desc = "Toggle indent guides",
      })
    end,
  },
}

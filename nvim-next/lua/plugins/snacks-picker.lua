-- Snacks picker utilities.
-- This replaces Telescope for many users.

return {
	{
		"folke/snacks.nvim",

		keys = {
			{
				"<leader>pf",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find files",
			},

			{
				"<leader>pg",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Live grep",
			},

			{
				"<leader>pb",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Find buffers",
			},

			{
				"<leader>ph",
				function()
					require("snacks").picker.help()
				end,
				desc = "Help pages",
			},

			{
				"<leader>pr",
				function()
					require("snacks").picker.recent()
				end,
				desc = "Recent files",
			},

			{
				"<leader>pc",
				function()
					-- Open your Neovim config directory directly.
					require("snacks").picker.files({
						cwd = vim.fn.stdpath("config"),
					})
				end,
				desc = "Find config files",
			},
		},

		opts = {
			picker = {
				enabled = true,
			},

			-- File explorer sidebar.
			explorer = {
				enabled = true,
			},
		},
	},
}

-- LSP configuration.
-- This file is inspired by LazyVim's data-driven LSP setup and AstroLSP's
-- conditional attach behavior, but it stays local and explicit.
--
-- Main ideas:
-- - put all server config in one `servers` table
-- - use `servers["*"]` for defaults shared by every server
-- - use `vim.lsp.config()` and `vim.lsp.enable()` instead of deprecated
--   `require("lspconfig").SERVER.setup()`
-- - create keymaps only when an attached server supports the feature

local servers = {
	-- Defaults for all language servers.
	["*"] = {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
		flags = {
			exit_timeout = 5000,
		},
	},

	bashls = {},
	clangd = {},
	cssls = {},
	html = {},
	jsonls = {
		settings = {
			json = {
				-- Filled in during LSP setup after schemastore.nvim is loaded.
				-- This gives jsonls access to common schemas like package.json,
				-- tsconfig.json, GitHub workflows, and many others.
				schemas = {},
				validate = {
					enable = true,
				},
			},
		},
	},
	prismals = {},
	rust_analyzer = {},
	terraformls = {},
	ts_ls = {},
	yamlls = {},

	-- Lua language server settings for editing Neovim config files.
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},

	-- Go language server settings carried over from the old CoC config.
	gopls = {
		settings = {
			gopls = {
				completeUnimported = true,
				gofumpt = true,
				staticcheck = true,
				usePlaceholders = false,
			},
		},
	},
}

local features = {
	codelens = true,
	-- Keep folding manual for now. Automatic LSP folds can be surprising because
	-- they change window-local fold behavior as soon as a language server attaches.
	folds = false,
	inlay_hints = true,
	semantic_tokens = true,
}

-- LazyVim uses short capability names in key specs. This maps those readable
-- names to actual LSP method names used by client:supports_method().
local capability_methods = {
	codeAction = "textDocument/codeAction",
	codeLens = "textDocument/codeLens",
	declaration = "textDocument/declaration",
	definition = "textDocument/definition",
	documentHighlight = "textDocument/documentHighlight",
	foldingRange = "textDocument/foldingRange",
	formatting = "textDocument/formatting",
	implementation = "textDocument/implementation",
	inlayHint = "textDocument/inlayHint",
	references = "textDocument/references",
	rename = "textDocument/rename",
	signatureHelp = "textDocument/signatureHelp",
	typeDefinition = "textDocument/typeDefinition",
}

local keys = {
	{ "gd", vim.lsp.buf.definition, desc = "Go to definition", has = "definition" },
	{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration", has = "declaration" },
	{ "gr", vim.lsp.buf.references, desc = "Go to references", has = "references", nowait = true },
	{ "gI", vim.lsp.buf.implementation, desc = "Go to implementation", has = "implementation" },
	{ "gy", vim.lsp.buf.type_definition, desc = "Go to type definition", has = "typeDefinition" },
	{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
	{ "gK", vim.lsp.buf.signature_help, desc = "Signature help", has = "signatureHelp" },
	{ "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature help", has = "signatureHelp" },
	{ "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "Code action", has = "codeAction" },
	{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename symbol", has = "rename" },
	{ "<leader>lf", vim.lsp.buf.format, desc = "Format with LSP", has = "formatting" },
	{ "<leader>cl", vim.lsp.codelens.run, mode = { "n", "x" }, desc = "Run codelens", has = "codeLens" },
	{
		"<leader>cL",
		function()
			vim.lsp.codelens.enable(true, { bufnr = 0 })
		end,
		desc = "Refresh codelens",
		has = "codeLens",
	},
	{ "<leader>e", vim.diagnostic.open_float, desc = "Line diagnostics" },
}

local function server_names()
	local names = {}

	for server, _ in pairs(servers) do
		if server ~= "*" then
			names[#names + 1] = server
		end
	end

	table.sort(names)

	return names
end

local function supports(client, bufnr, capability)
	if not capability then
		return true
	end

	local method = capability_methods[capability] or capability

	return client:supports_method(method, bufnr)
end

local function key_enabled(key, client, bufnr)
	if key.has and not supports(client, bufnr, key.has) then
		return false
	end

	if key.enabled == nil then
		return true
	end

	if type(key.enabled) == "boolean" then
		return key.enabled
	end

	if type(key.enabled) == "function" then
		return key.enabled(bufnr, client)
	end

	return false
end

local function setup_keymaps(client, bufnr)
	for _, key in ipairs(keys) do
		if key_enabled(key, client, bufnr) then
			local lhs = key[1]
			local rhs = key[2]
			local mode = key.mode or "n"

			vim.keymap.set(mode, lhs, rhs, {
				buffer = bufnr,
				desc = key.desc,
				nowait = key.nowait,
			})
		end
	end
end

local function setup_document_highlight(client, bufnr)
	if not supports(client, bufnr, "documentHighlight") then
		return
	end

	local group = vim.api.nvim_create_augroup("UserLspDocumentHighlight", { clear = false })

	vim.api.nvim_clear_autocmds({
		group = group,
		buffer = bufnr,
	})

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = group,
		buffer = bufnr,
		desc = "Highlight symbol under cursor",
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
		group = group,
		buffer = bufnr,
		desc = "Clear symbol highlights",
		callback = vim.lsp.buf.clear_references,
	})
end

local function setup_features(client, bufnr)
	if features.semantic_tokens == false then
		client.server_capabilities.semanticTokensProvider = nil
	end

	if features.inlay_hints and vim.lsp.inlay_hint and supports(client, bufnr, "inlayHint") then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end

	if features.codelens and vim.lsp.codelens and supports(client, bufnr, "codeLens") then
		vim.lsp.codelens.enable(true, { bufnr = bufnr })

		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("UserLspCodeLens", { clear = false }),
			buffer = bufnr,
			desc = "Refresh codelens",
			callback = function()
				vim.lsp.codelens.enable(true, { bufnr = bufnr })
			end,
		})
	end

	if features.folds and supports(client, bufnr, "foldingRange") then
		-- Use LSP-powered folds only when the user has not chosen another fold
		-- method. This keeps manual project/filetype choices from being clobbered.
		if vim.wo.foldmethod == "manual" then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end
end

local function default_lsp_config()
	local defaults = vim.deepcopy(servers["*"])
	local ok, blink = pcall(require, "blink.cmp")

	if ok then
		-- blink.cmp exposes extra completion capabilities for LSP servers.
		-- Use them when available, but keep LSP startup working during the first
		-- plugin install when blink may not have been cloned yet.
		defaults.capabilities = blink.get_lsp_capabilities(defaults.capabilities)
	end

	return defaults
end

return {
	-- Mason installs external developer tools such as language servers.
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},

	-- mason-lspconfig installs LSP servers and bridges Mason server names to
	-- Neovim/nvim-lspconfig server names.
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			-- Provides the SchemaStore catalog to jsonls/yamlls.
			"b0o/schemastore.nvim",
		},
		opts = {
			ensure_installed = server_names(),

			-- This file configures and enables servers explicitly. Mason should
			-- install servers, not decide which configs to enable.
			automatic_enable = false,
		},
	},

	-- nvim-lspconfig provides server definitions used by vim.lsp.config().
	{
		"neovim/nvim-lspconfig",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local ok, schemastore = pcall(require, "schemastore")

			if ok then
				servers.jsonls.settings.json.schemas = schemastore.json.schemas()
			end

			vim.lsp.config("*", default_lsp_config())

			for _, server in ipairs(server_names()) do
				vim.lsp.config(server, servers[server])
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				desc = "Configure LSP behavior for attached buffers",
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if not client then
						return
					end

					setup_features(client, event.buf)
					setup_document_highlight(client, event.buf)
					setup_keymaps(client, event.buf)
				end,
			})

			vim.lsp.enable(server_names())
		end,
	},
}

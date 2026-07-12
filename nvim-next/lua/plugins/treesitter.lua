-- Treesitter configuration.
-- Treesitter parses source code into syntax trees. Neovim can use those trees
-- for highlighting and indentation that is more accurate than regex syntax.
--
-- This follows the newer nvim-treesitter API, similar to AstroCore's approach:
-- install parsers with nvim-treesitter, then enable Neovim's built-in
-- Treesitter features per buffer after checking parser/query support.

local parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "prisma",
  "python",
  "query",
  "rust",
  "sql",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  -- nvim-treesitter now mainly installs parsers and query files.
  -- Highlighting itself is started through Neovim's vim.treesitter API.
  {
    "nvim-treesitter/nvim-treesitter",

    -- The new nvim-treesitter API should not be lazy-loaded because parser
    -- commands and query runtime files need to be available immediately.
    lazy = false,

    -- Update installed parsers when the plugin updates.
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")

      if vim.fn.executable("tree-sitter") ~= 1 then
        vim.notify(
          "`tree-sitter` CLI is required for nvim-treesitter's new API. Install it before parser setup runs.",
          vim.log.levels.WARN,
          { title = "Treesitter" }
        )

        return
      end

      -- Cache parser/query checks so FileType events stay cheap.
      local available = {}
      local installed = {}
      local queries = {}

      local function refresh_available()
        available = {}

        for _, parser in ipairs(treesitter.get_available()) do
          available[parser] = true
        end
      end

      local function refresh_installed()
        installed = {}

        for _, parser in ipairs(treesitter.get_installed("parsers")) do
          installed[parser] = true
        end
      end

      local function language_for_buffer(bufnr)
        local filetype = vim.bo[bufnr].filetype

        return vim.treesitter.language.get_lang(filetype), filetype
      end

      local function has_query(language, query)
        local key = language .. ":" .. query

        if queries[key] == nil then
          queries[key] = vim.treesitter.query.get(language, query) ~= nil
        end

        return queries[key]
      end

      local function has_parser(bufnr, query)
        local language = language_for_buffer(bufnr)

        if not language or not installed[language] then
          return false
        end

        if query and not has_query(language, query) then
          return false
        end

        return true
      end

      local function install_missing(languages, callback)
        local missing = vim.tbl_filter(function(language)
          return available[language] and not installed[language]
        end, languages)

        if #missing == 0 then
          if callback then
            callback()
          end

          return
        end

        -- install() is asynchronous. After it finishes, refresh the cache and
        -- retry enabling Treesitter for the buffer that triggered the install.
        treesitter.install(missing, { summary = true }):await(function()
          refresh_installed()

          if callback then
            vim.schedule(callback)
          end
        end)
      end

      local function enable_for_buffer(bufnr)
        if not vim.api.nvim_buf_is_valid(bufnr) then
          return
        end

        -- Highlighting needs a "highlights" query for the parser language.
        -- This mirrors AstroCore's guarded behavior and prevents startup noise
        -- for filetypes with parsers but incomplete query support.
        if has_parser(bufnr, "highlights") then
          pcall(vim.treesitter.start, bufnr)
        end

        -- Treesitter indentation is useful, but only enable it for parsers that
        -- ship an "indents" query. Unsupported languages keep normal indenting.
        if has_parser(bufnr, "indents") then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      -- native-markup has no grammar of its own, but its syntax is HTML-like,
      -- so highlight those buffers with the HTML parser.
      vim.treesitter.language.register("html", "native-markup")

      -- Configure where nvim-treesitter installs parser/query files.
      treesitter.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      refresh_available()
      refresh_installed()
      install_missing(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        desc = "Enable Treesitter features when parser support exists",
        callback = function(event)
          local language = language_for_buffer(event.buf)

          if not language then
            return
          end

          -- Plugin/UI buffers can have filetypes like "fidget" that do not
          -- correspond to real Treesitter parser names. Skip them instead of
          -- asking nvim-treesitter to install an unsupported parser.
          if not available[language] then
            return
          end

          if installed[language] then
            enable_for_buffer(event.buf)
          else
            install_missing({ language }, function()
              enable_for_buffer(event.buf)
            end)
          end
        end,
      })
    end,
  },
}

-- Core editor options.
-- These settings do not depend on plugins and should work in plain Neovim.

local opt = vim.opt

-- Use true color in the terminal so themes render corrrectly.
opt.termguicolors = true

-- Show absolute line number on the current line and relative numbers elsewhere.
-- This makes motions like 5j or 3k easier to count.
opt.number = true
opt.relativenumber = true

-- Keep the sign column, makes diagnostics and git signs to not shift text.
opt.signcolumn = "yes"

-- Keep some context visible above and below the cursor.
opt.scrolloff = 20

-- Use spaces instead of tabs by default.
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Copy indentation from previous line
opt.autoindent = true
opt.smartindent = true

-- Wrap long lines visually, but do not insert actual line breaks.
opt.wrap = false
opt.linebreak = true

-- Search behavior: ignore case unless the query contains uppercase letters.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Command-line completion.
-- This improves completion for commands like :edit, :buffer, and :help
opt.wildmenu = true
opt.wildignorecase = true
opt.wildmode = "longest:full,full"

-- Ignore common generated directories when using command-line file completion.
opt.wildignore:append({
  "**/node_modules/**",
  "**/dist/**",
  "**/tmp/**",
  "**/target/**",
  "**/.git/**",
})

-- Search project files with commands like :find.
-- "." means current file directory; "**" allows recursive search.
opt.path = { ".", "**" }

-- Preview substitution live in a split window.
opt.inccommand = "split"

-- Ask before closing a modified buffer instead of failing the command.
opt.confirm = true

-- Save undo history between Neovim sessions.
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Do not create swap files. Persistent undo already covers most recovery needs.
opt.swapfile = false

-- Show invisible characters in a subtle way.
opt.list = true
opt.listchars = {
  -- Do not draw tabs as arrows. The indent guide plugin owns indentation
  -- visuals, and visible tab arrows can hide those vertical guide lines.
  tab = "  ",
  trail = "·",
  nbsp = "␣",
}

-- Show a vertical guide at 80 columns.
opt.colorcolumn = "80"

-- Hightlight the current line.
opt.cursorline = true

-- Enable mouse support.
opt.mouse = "a"

-- Make completion menus feel responsive.
opt.updatetime = 300
opt.timeoutlen = 500

-- Better split defaults
opt.splitright = true
opt.splitbelow = true

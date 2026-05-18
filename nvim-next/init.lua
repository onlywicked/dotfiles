-- Enable Neovim's Lua module cache.
-- This makes configs split across multiple lua files load faster.
vim.loader.enable()

-- Leader keys must be set before plugins are loaded.
-- Many plugin keymaps use <leader>, so, defining it early.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core editor behavior.
-- These files should not depend on plugins.
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")
require("config.netrw")

-- Bootstrap lazy.nvim, our plugin manager.
-- If lazy.nvim is not installed yet, we would be cloning it automatically.
-- NOTE: requires git to be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Add lazy.nvim to Neovim's runtime path so it can be required below.
vim.opt.rtp:prepend(lazypath)

-- Load plugins specs from lua/plugins/*.lua.
-- It keeps it clean instead of one gigantic file spread configuration all over
-- a single file.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },

  -- Check for plugin updates in the background
  checker = {
    enabled = true,
    notify = false,
  },
})

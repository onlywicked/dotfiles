-- Filetype detection.
-- Custom extension-to-filetype mappings must exist before FileType
-- autocommands run so LSP attach and Treesitter see the right filetype.

vim.filetype.add({
  extension = {
    native = "native-markup",
  },
})

local set = vim.o

-- Make line numbers default
set.number = true
set.relativenumber = true
set.signcolumn = 'yes:2'

-- No wrap at the end of the screen
set.wrap = false

-- Spaces, no tabs and default indent without LSP
set.expandtab = true
set.shiftwidth = 2

-- Enable mouse mode, can be useful for resizing splits for example!
set.mouse = 'a'

-- Don't show the mode, since it's already in the status line
set.showmode = false

-- Save undo history
set.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
set.ignorecase = true
set.smartcase = true

-- Sets how neovim will display certain whitespace characters in the editor.
set.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
set.inccommand = 'split'

-- Show which line your cursor is on
set.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
set.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
set.confirm = true

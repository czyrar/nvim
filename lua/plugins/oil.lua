-- Edit files as a buffer
vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
}

local oil = require 'oil'
oil.setup { view_options = { show_hidden = true } }
oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

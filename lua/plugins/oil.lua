-- Edit files as a buffer
local oil = require 'oil'
oil.setup { view_options = { show_hidden = true } }
oil.set_columns { 'icon', 'permissions', 'size', 'mtime' }
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

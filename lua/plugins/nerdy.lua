-- Nerd font icons
vim.pack.add {
  'https://github.com/2kabhishek/nerdy.nvim',
  'https://github.com/folke/snacks.nvim',
}

require('snacks').setup()
require('nerdy').setup {
  max_recents = 30,
  copy_to_clipboard = false
}

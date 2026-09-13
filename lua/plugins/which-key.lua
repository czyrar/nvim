-- Help with keybinds
vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/which-key.nvim',
}

require('nvim-web-devicons').setup {}
require('which-key').setup { preset = 'helix' }

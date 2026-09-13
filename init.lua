vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'keymaps'
require 'options'
require 'autocmds'

-- Theme
vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
}
require('tokyonight').setup { style = 'night' }
vim.cmd.colorscheme 'tokyonight'

-- Load plugins
require 'plugins.fidget'
require 'plugins.which-key'
require 'plugins.blink'
require 'plugins.Comment'
require 'plugins.compile-mode'
require 'plugins.gitsigns'
require 'plugins.lazydev'
require 'plugins.lualine'
require 'plugins.nerdy'
require 'plugins.nvim-highlight-colors'
require 'plugins.nvim-lspconfig'
require 'plugins.nvim-surround'
require 'plugins.nvim-toggleterm'
require 'plugins.nvim-treesitter'
require 'plugins.oil'
require 'plugins.render-markdown'
require 'plugins.targets'
require 'plugins.telescope'
require 'plugins.todo-comments'

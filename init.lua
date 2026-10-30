vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'keymaps'
require 'options'

-- Theme
vim.pack.add {
  'https://github.com/folke/tokyonight.nvim',
}
require('tokyonight').setup { style = 'night' }
vim.cmd.colorscheme 'tokyonight'

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Establish a mapping of filetypes
local mapping = {
  fypp = 'fortran',
}
vim.filetype.add {
  extension = mapping,
}

-- Open help windows as vertical splits
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-vertical-help', { clear = true }),
  pattern = 'help',
  callback = function()
    vim.cmd 'wincmd L'
  end,
})

-- Load plugins
require 'plugins.fidget'
require 'plugins.which-key'
require 'plugins.lualine'
require 'plugins.nvim-highlight-colors'
require 'plugins.nvim-surround'
require 'plugins.oil'
require 'plugins.targets'
require 'plugins.telescope'
require 'plugins.todo-comments'

-- Disable features when file is too big
local soft_lim = 5 * 1024 * 1024 -- 5MB
local hard_lim = 10 * soft_lim -- 50MB
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('my-bigfile', { clear = true }),
  callback = function(args)
    local fidget = require 'fidget'
    local ft = vim.filetype.match { buf = args.buf } or ''
    local size = vim.fn.getfsize(args.file)
    if size < soft_lim then
      require 'plugins.blink'
      require 'plugins.nvim-lspconfig'
      require 'plugins.nvim-treesitter'
    end
    if size < hard_lim then
      require 'plugins.Comment'
      require 'plugins.compile-mode'
      require 'plugins.gitsigns'
      require 'plugins.nerdy'
      require 'plugins.render-markdown'
    end
  end,
})

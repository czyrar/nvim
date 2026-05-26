-- Set <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Mappings
require 'keymaps'

-- Options
require 'options'

-- Autocmds
require 'autocmds'

-- Plugins
vim.pack.add {
  -- Themes
  'https://github.com/folke/tokyonight.nvim',
  -- Dependencies
  'https://github.com/saghen/blink.lib', -- blink
  'https://github.com/rafamadriz/friendly-snippets', -- blink
  'https://github.com/folke/lazydev.nvim', -- gitsigns
  'https://github.com/nvim-tree/nvim-web-devicons', -- lualine
  'https://github.com/mason-org/mason.nvim', -- nvim-lspconfig
  'https://github.com/mason-org/mason-lspconfig.nvim', -- nvim-lspconfig
  'https://github.com/nvim-lua/plenary.nvim', -- telescope
  'https://github.com/nvim-telescope/telescope-ui-select.nvim', --telescope
  'https://github.com/nvim-tree/nvim-web-devicons', -- telescope, which-key
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim', -- telescope
  -- Packages
  'https://github.com/saghen/blink.cmp',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/brenoprata10/nvim-highlight-colors',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/akinsho/nvim-toggleterm.lua',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/wellle/targets.vim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/romus204/tree-sitter-manager.nvim',
  'https://github.com/folke/which-key.nvim',
}

-- Build what's needed
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})
require('blink.cmp').build()

-- Setup basic dependencies
require('nvim-web-devicons').setup {}
require('which-key').setup { preset = 'helix' }
require('fidget').setup {}
require('blink.cmp').setup {
  signature = { enabled = true },
}
require('mason').setup {}
require('mason-lspconfig').setup {}

-- Load the rest
for file_name, type in vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('plugins.' .. module)
  end
end

-- Set the theme
vim.cmd.colorscheme 'tokyonight-night'

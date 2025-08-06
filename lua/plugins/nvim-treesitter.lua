-- Allow to understand nodes and childs from languages.
-- This permits better textobjects, show context, highlights and indent.
-- Configured to autoinstall languages.
local noinstall = {}
return {
  { -- Base plugin
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
  },
  { -- Add context
    'nvim-treesitter/nvim-treesitter-context',
  },
  { -- Surrounds for [f]unction, [C]lass, [l]oop, [c]onditional
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    config = function()
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@function.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@function.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'aC', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@class.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'iC', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@class.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'al', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@loop.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'il', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@loop.inner', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@condition.outer', 'textobjects')
      end)
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require 'nvim-treesitter-textobjects.select'.select_textobject('@condition.inner', 'textobjects')
      end)
    end,
  },
  { -- Autoinstall, highlight and incremental selection
    'MeanderingProgrammer/treesitter-modules.nvim',
    config = function()
      require('which-key').add({ 'gr', group = 'Code select', mode = 'v' })
      require('treesitter-modules').setup {
        ensure_installed = { 'lua' },
        ignore_install = noinstall,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = false,
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grp',
          },
        },
        indent = { enable = true },
      }
    end,
  },
}

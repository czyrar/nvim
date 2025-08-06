-- Allow to understand nodes and childs from languages.
-- This permits better textobjects, show context, highlights and indent.
-- Configured to autoinstall languages.
local noinstall = {}
return {
  { -- Base plugin
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      -- Ensure we have for the documentation
      local treesitter = require('nvim-treesitter')
      treesitter.install({ 'lua', 'luadoc' })

      -- Auto install and start
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('my-treesitter-install', { clear = true }),
        callback = function(args)
          local buf = args.buf
          local filetype = args.match
          local language = vim.treesitter.language.get_lang(filetype) or filetype
          if noinstall[language] then
            return
          end
          treesitter.install(language)
          if not vim.treesitter.language.add(language) then
            return
          end
          vim.treesitter.start(buf, language)
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  { -- Add context
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { desc = '[G]oto [C]ontext', silent = true })
    end
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
}

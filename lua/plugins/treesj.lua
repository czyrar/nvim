-- Toggle multiline
return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
  config = function()
    require('treesj').setup {
      use_default_keymaps = false,
      max_join_length = 512,
    }
    vim.keymap.set('n', 'gs', function()
      require('treesj').toggle()
    end, { desc = 'Toggle multiline' })
    vim.keymap.set('n', 'gS', function()
      require('treesj').toggle { split = { recursive = true } }
    end, { desc = 'Toggle multiline (recursive)' })
  end,
}

-- Surround:
-- [ys] add
-- [ds] delete
-- [cs] change surround
return {
  'kylechui/nvim-surround',
  dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      keymaps = {
        insert = false,
        insert_line = false,
        normal = 'ys',
        normal_cur = false,
        normal_line = false,
        normal_cur_line = false,
        visual = false,
        visual_line = false,
        delete = 'ds',
        change = 'cs',
        change_line = false,
      },
    }
  end,
}

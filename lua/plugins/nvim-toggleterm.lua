-- Terminal with support to send lines
return {
  'akinsho/nvim-toggleterm.lua',
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup {
      open_mapping = '<C-\\>',
      insert_mappings = false,
      hide_number = true,
      start_in_insert = true,
      direction = 'vertical',   -- vertical | float | tab
      size = 40,
    }
    vim.keymap.set("n", "<leader>t", function()
      vim.cmd(':normal v')
      require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
    end, { desc = 'Send lines to [T]erminal' })
    vim.keymap.set("v", "<leader>t", function()
      require("toggleterm").send_lines_to_terminal("visual_lines", false, { args = vim.v.count })
    end, { desc = 'Send lines to [T]erminal' })
  end,
}

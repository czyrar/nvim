-- NVim 0.12 Tree-sitter
require('tree-sitter-manager').setup {
  auto_install = true,
}
vim.keymap.set('n', '<leader>T', '<cmd>TSManager<CR>', { desc = 'Open [T]ree-sitter Manager' })

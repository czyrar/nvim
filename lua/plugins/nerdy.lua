require('nerdy').setup {
  max_recents = 30,
  copy_to_clipboard = false
}
require('which-key').add {
  { '<leader>n', group = '[N]erdy', mode = 'n' },
  {
    '<leader>nl',
    '<cmd>Nerdy list<CR>',
    desc = '[N]erdy [l]ist',
    mode = 'n',
  },
  {
    '<leader>nr',
    '<cmd>Nerdy recent<CR>',
    desc = '[N]erdy [r]ecent',
    mode = 'n',
  },
}

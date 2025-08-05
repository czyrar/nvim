local map = vim.keymap.set

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keymaps to make insert movement easier.
map('i', '<C-h>', '<left>')
map('i', '<C-l>', '<right>')
map('i', '<C-j>', '<down>')
map('i', '<C-k>', '<up>')

-- Move code blocks
map('v', 'J', ':m +1<CR>gv=gv', { desc = 'Move line upwards' })
map('v', 'K', ':m -2<CR>gv=gv', { desc = 'Move line downwards' })

-- Paste replace
map('x', '<leader>p', '"_dP', { desc = '[P]aste preserving register' })

-- System clipboard copy
map({ 'n', 'v', 'x' }, 'Y', 'yy', { desc = '[Y]ank line' })
map({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
map('n', '<leader>Y', '"+Y', { desc = '[Y]ank line to system clipboard' })

-- Delete and don't save
map({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without yank' })

-- Easier Esc
map('i', '<C-c>', '<Esc>')

-- Disable highlight when we are done
map('n', '<C-c>', '<cmd>nohlsearch<CR>')
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Fix rounded borders not working with telescope
map('n', 'K', function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = 'Hover Documentation' })

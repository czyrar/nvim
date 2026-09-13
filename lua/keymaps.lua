-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move code blocks
vim.keymap.set('v', 'J', ':m +1<CR>gv=gv', { desc = 'Move line upwards' })
vim.keymap.set('v', 'K', ':m -2<CR>gv=gv', { desc = 'Move line downwards' })

-- Paste replace
vim.keymap.set('x', '<leader>p', '"_dP', { desc = '[P]aste preserving register' })

-- System clipboard copy
vim.keymap.set({ 'n', 'v', 'x' }, 'Y', 'yy', { desc = '[Y]ank line' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank line to system clipboard' })

-- Delete and don't save
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete without yank' })

-- Easier Esc
vim.keymap.set('i', '<C-c>', '<Esc>')

-- Disable highlight when we are done
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Execute lua for configs
vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'E[x]ecute Lua line' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'E[x]ecute Lua block' })

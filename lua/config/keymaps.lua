local map = vim.keymap.set

map('i', 'jj', '<esc>')

-- Window Splittings
map('n', '-', '<cmd>sp<cr>')
map('n', '|', '<cmd>vs<cr>')

-- Window Movings
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Window Resizings
-- TODO: Configure this
map('n', '<C-w><C-h>', '<cmd>vertical resize -4<cr>')
map('n', '<C-w><C-j>', '<cmd>resize +4<cr>')
map('n', '<C-w><C-k>', '<cmd>resize -4<cr>')
map('n', '<C-w><C-l>', '<cmd>vertical resize +4<cr>')

map('i', '<C-f>', '<Right>')
map('i', '<C-b>', '<Left>')
map('i', '<C-e>', '<esc>A')
map('i', '<C-a>', '<esc>I')

map('n', '<leader>o', '<cmd>only<cr>')
map('n', '<S-w>', '<cmd>write<cr>')
map('n', '<S-q>', '<cmd>quit<cr>')
map('n', '<leader>w', '<cmd>write<cr>')
map('n', '<leader>q', '<cmd>quit<cr>')

map('n', '(', '<cmd>bp<cr>')
map('n', ')', '<cmd>bn<cr>')

map('n', '<S-h>', '^')
map('n', '<S-l>', '$')


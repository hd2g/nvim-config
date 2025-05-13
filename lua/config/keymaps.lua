local map = vim.keymap

-- Window Splittings
map.set('n', '-', '<cmd>sp<cr>')
map.set('n', '|', '<cmd>vs<cr>')

-- Window Movings
map.set('n', '<C-h>', '<C-w>h')
map.set('n', '<C-j>', '<C-w>j')
map.set('n', '<C-k>', '<C-w>k')
map.set('n', '<C-l>', '<C-w>l')

map.set('n', '<leader>o', '<cmd>only<cr>')

-- Window Resizings
-- TODO: Configure this
map.set('n', '<C-w><C-h>', '<cmd>vertical resize -5<cr>')
map.set('n', '<C-w><C-j>', '<cmd>resize +5<cr>')
map.set('n', '<C-w><C-k>', '<cmd>resize -5<cr>')
map.set('n', '<C-w><C-l>', '<cmd>vertical resize +5<cr>')

map.set('i', '<C-f>', '<Right>')
map.set('i', '<C-b>', '<Left>')

map.set('n', '<S-w>', '<cmd>w<cr>')
map.set('n', '<S-q>', '<cmd>q<cr>')

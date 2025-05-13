return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>/', builtin.live_grep)
    vim.keymap.set('n', '<leader>b', builtin.buffers)
    vim.keymap.set('n', '<leader>s', builtin.current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>gf', builtin.git_files)
    vim.keymap.set('n', '<leader>gc', builtin.git_commits)
    vim.keymap.set('n', 'dl', '<cmd>Telescope diagnostics<cr>')
  end,
}

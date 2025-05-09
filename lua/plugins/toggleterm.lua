return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm<cr>')
    end,
  }
}

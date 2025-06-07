return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm direction=float<cr>')
      vim.keymap.set('t', '<C-t>', '<cmd>ToggleTerm direction=float<cr>')
    end,
  }
}


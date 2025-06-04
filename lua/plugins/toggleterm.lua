return {
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
      vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm direction=float<cr>')
    end,
  }
}


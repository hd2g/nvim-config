return {
  "vim-skk/eskk.vim",
  config = function()
    vim.keymap.set('i', 'jk', '<esc><cmd>call eskk#toggle()<cr>i')
  end
}


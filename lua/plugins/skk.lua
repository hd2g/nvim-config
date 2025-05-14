return {
  "vim-skk/eskk.vim",
  config = function()
    vim.cmd [[
      let g:eskk#dictionary = { 'path': '~/.skk-jisyo', 'sorted': 0, 'encoding': 'euc-jp' }
    ]]
    vim.keymap.set('i', 'jk', '<esc><cmd>call eskk#toggle()<cr>i')
  end
}


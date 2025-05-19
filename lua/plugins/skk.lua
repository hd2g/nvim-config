return {
  "vim-skk/eskk.vim",
  config = function()
    vim.cmd [[
      let g:eskk#dictionary = { 'path': '~/.skk-jisyo', 'sorted': 0, 'encoding': 'euc-jp' }
      let g:eskk#large_dictionary = { 'path': '/nix/store/j6pswq2z4d6hizaj00xki76dznl62cl3-skk-jisyo-l-0-unstable-2024-08-28/share/skk/SKK-JISYO.L', 'sorted': 0, 'encoding': 'euc-jp' }
    ]]
    vim.keymap.set('i', 'jk', '<esc><cmd>call eskk#toggle()<cr>i')
  end
}


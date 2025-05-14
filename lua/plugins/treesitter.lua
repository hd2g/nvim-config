return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = false,
      highlight = {
        enable = true,
      },
    }

    require('nvim-treesitter.configs').setup({
      ignore_install = { 'org' },
    })

    vim.filetype.add({ extension = { purs = 'purescript' }})
   end,
}


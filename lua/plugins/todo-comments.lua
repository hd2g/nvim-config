return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    require('todo-comments').setup{
      signs = false,
    }
    vim.keymap.set('n', '<leader>t', '<cmd>TodoTelescope<cr>')
    vim.keymap.set('n', '<leader>l', '<cmd>TodoLocList<cr>')
  end,
}

return {
  "https://github.com/numToStr/Comment.nvim",
  event = "VeryLazy", -- Special lazy.nvim event for things that can load later and are not important for the initial UI
  config = function()
    require("Comment").setup{
      toggler = {
        ---Line-comment toggle keymap
        line = '<C-c>',
        ---Block-comment toggle keymap
        -- block = '<C-C>',
      },
      opleader = {
        ---Line-comment toggle keymap
        line = '<C-c>',
        ---Block-comment toggle keymap
        -- block = '<C-C>',
      },
    }
  end,
}

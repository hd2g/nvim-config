return {
  { "mason-org/mason.nvim" },

  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup{
        automatic_enable = false
      }
    end,
  },

  { "neovim/nvim-lspconfig" }
}

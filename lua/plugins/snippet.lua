return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	-- build = "make install_jsregexp",
  config = function()
    -- Load snippets
    require("luasnip.loaders.from_snipmate").lazy_load {
      paths = {
        '~/.config/nvim/snippets'
      }
    }

    -- Setup keymaps
    local ls = require("luasnip")

    vim.keymap.set({"i"}, "<C-k>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-l>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump(-1) end, {silent = true})

    vim.keymap.set({"i", "s"}, "<C-e>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent = true})
  end
}

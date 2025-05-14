local opt = vim.o

opt.background = "light"

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

vim.cmd [[
set colorcolumn=80,120
]]

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.splitright = true
opt.splitbelow = true

opt.hlsearch = false
opt.swapfile = false
opt.modeline = false

opt.showtabline = 0

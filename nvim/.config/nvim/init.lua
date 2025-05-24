vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = "menuone,noselect"
vim.opt.guicursor = ""
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.updatetime = 500
vim.opt.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n" }, "<leader>Y", '"+yg_')

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("TextYankPostGroup", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

require("config.lazy")

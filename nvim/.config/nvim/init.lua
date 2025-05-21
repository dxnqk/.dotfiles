vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.completeopt = 'menuone,noselect'
vim.opt.smartindent = true
vim.opt.updatetime = 500
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.guicursor = ''
vim.opt.wrap = false

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n' }, '<leader>Y', '"+yg_')

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('TextYankPostGroup', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                disable_float_background = true,
                disable_background = true,
                disable_italics = true,
            })

            vim.cmd.colorscheme('rose-pine')
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function () 
            require('nvim-treesitter.configs').setup({
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },  
        })
        end
    }
})

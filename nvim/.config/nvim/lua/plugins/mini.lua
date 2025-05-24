return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup()
      require("mini.icons").setup()
      require("mini.pairs").setup()
      require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
      require("mini.surround").setup()
    end,
  },
}

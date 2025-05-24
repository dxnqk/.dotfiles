return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        php = { "php-cs-fixer" },
      },
    },
    keys = {
      {
        "<leader>fmt",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
      },
    },
  },
}

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier", "rustywind" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        sh = { "shfmt" },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    },
  },
}

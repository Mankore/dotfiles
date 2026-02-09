-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/mason-org/mason.nvim
-- https://github.com/mason-org/mason-lspconfig.nvim
return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "html",
      "ts_ls",
      "lua_ls",
      "tailwindcss",
    },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}

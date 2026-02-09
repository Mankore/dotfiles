-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "html",
        "lua",
        "javascript",
        "typescript",
        "angular",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
    },
  },
}

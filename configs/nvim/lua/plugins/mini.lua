-- https://github.com/nvim-mini/mini.nvim
return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })

      require("mini.surround").setup()

      require("mini.move").setup()
    end,
  },
}

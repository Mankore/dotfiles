-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    local parsers = {
      "lua",
      "luadoc",
      "typescript",
      "javascript",
      "tsx",
      "jsx",
      "angular",
      "html",
      "html_tags",
      "json",
      "bash",
      "diff",
      "markdown",
      "markdown_inline",
      "vim",
    }
    require("nvim-treesitter").install(parsers)

    local filetypes = {
      "lua",
      "luadoc",
      "typescript",
      "javascript",
      "tsx",
      "jsx",
      "angular",
      "typescriptreact",
      "html",
      "html_tags",
      "json",
      "bash",
      "diff",
      "markdown",
      "markdown_inline",
      "vim",
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        print("Starting treesitter for " .. vim.bo.filetype)
        vim.treesitter.start()
      end,
    })
  end,
}

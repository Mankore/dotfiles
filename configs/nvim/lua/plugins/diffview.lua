return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",                    desc = "Diffview: open" },
    { "<leader>gD", "<cmd>DiffviewClose<CR>",                   desc = "Diffview: close" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>",           desc = "Diffview: file history" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<CR>",             desc = "Diffview: repo history" },
    { "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<CR>", desc = "Diffview: vs main" },
  },
  opts = {},
}

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal" },
      { "<leader>e", ":Neotree toggle<CR>", desc = "NeoTree toggle" },
    },
    opts = {
      filesystem = {
        window = {
          position = "right",
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

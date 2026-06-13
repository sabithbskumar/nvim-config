return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    keys = {
      { "<M-.>", ":BufferLineCycleNext<CR>" },
      { "<M-,>", ":BufferLineCyclePrev<CR>" },

      { "<M->>", ":BufferLineMoveNext<CR>" },
      { "<M-S-.>", ":BufferLineMoveNext<CR>" },

      { "<M-<>", ":BufferLineMovePrev<CR>" },
      { "<M-S-,>", ":BufferLineMovePrev<CR>" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et

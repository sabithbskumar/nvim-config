return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      flavour = "macchiato",
      no_italic = true,
      transparent_background = true,
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

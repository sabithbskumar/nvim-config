return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")
      startify.section.header.val = {
        " ┏━┓ ┏         ┓  ┏  •       ",
        " ┃ ┃ ┃ ┏━┓ ┏━┓ ┗┓┏┛  ┓ ┏━┳━┓ ",
        " ┛ ┗━┛ ┗━━ ┗━┛  ┗┛   ┗ ┗ ┗ ┗ ",
      }
      startify.section.header.opts.hl = "Title"

      alpha.setup(startify.config)
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

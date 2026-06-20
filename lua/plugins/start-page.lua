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

      -- change the 'MRU' text with '[.]'
      startify.section.mru_cwd.val = function()
        local cwd = vim.fn.getcwd()
        local fnamemodify = vim.fn.fnamemodify
        return {
          { type = "padding", val = 1 },
          { type = "text", val = "[.] " .. fnamemodify(cwd, ":~"), opts = { hl = "SpecialComment", shrink_margin = false } },
          { type = "padding", val = 1 },
          {
            type = "group",
            val = function()
              return { startify.mru(0, cwd) }
            end,
            opts = { shrink_margin = false },
          },
        }
      end

      -- disable MRU
      startify.section.mru.val = { { type = "padding", val = 0 } }
      -- disable file_icons
      startify.file_icons.enabled = false

      alpha.setup(startify.config)

      -- autocommand to hide the '~' character
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.opt_local.fillchars:append({
            eob = " ",
          })
        end,
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

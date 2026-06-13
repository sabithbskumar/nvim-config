return {
  {
    "nvim-mini/mini.nvim",
    config = function()
      -- If a nerd font is available, load icons
      if vim.g.use_nerd_font then
        require("mini.icons").setup()
        -- Backwards compatibility with nvim-web-devicons
        MiniIcons.mock_nvim_web_devicons()
      end

      -- Statusline
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.use_nerd_font })

      -- Configure sections in the statusline by overriding their
      -- default behavior.
      -- Set the section for cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et

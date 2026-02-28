-- [[ Utility function to safely load a Lua module ]]
-- Uses `pcall` to require a module and notifies on error.
local import = function(module_name)
  local success, result = pcall(require, module_name)
  if not success then
    vim.notify("Error loading module: " .. result, vim.log.levels.ERROR)
  end
  return result
end

-- [[ Configure and install plugins ]]
--
--  To check the current status of the plugins, run
--    :Lazy
--
--  To update plugins run
--    :Lazy update
--
require("lazy").setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  -- Use `opts = {}` to force a plugin to be loaded.

  -- Detect tabstop and shiftwidth automatically
  "NMAC427/guess-indent.nvim",

  import("plugins.theme"),
}, {
  ui = {
    icons = vim.g.use_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et

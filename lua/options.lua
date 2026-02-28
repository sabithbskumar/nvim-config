-- [[ Setting options ]]
-- See `:help vim.o`
--  For more options, see `:help option-list`

-- Show line numbers by default
vim.o.number = true

-- Enable mouse mode, useful for resizing splits
vim.o.mouse = "a"

-- Hide the mode since it will be in status line plugin
vim.o.showmode = false

-- Enable indent breaking
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how certain whitespace characters will be displayed.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show live preview for string substitution
vim.o.inccommand = "split"

-- Show which line the cursor is on
vim.o.cursorline = true

-- Minimum number of lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- Set indent options
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.tabstop = 2 -- Number of spaces that a tab represents
vim.o.softtabstop = 2 -- Number of spaces to insert when pressing Tab
vim.o.shiftwidth = 2 -- Number of spaces for auto-indentation
vim.o.smartindent = true -- Automatically indent new lines based on context

-- Show confirmaition when an operation that would fail due to unsaved changes in the buffer (like `:q`)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Set soft char limit
vim.o.colorcolumn = "80"
vim.o.textwidth = 80

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
})

-- vim: ts=2 sts=2 sw=2 et

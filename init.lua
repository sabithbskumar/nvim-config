-- Mapping space as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Install 'lazy.nvim' plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Plugin Config
require("lazy").setup({
  -- Git helper plugin
  'tpope/vim-fugitive',

  -- Detetc tabstop and tabwidth automatically
  "tpope/vim-sleuth",

  -- Auto closes parenthesis
  'jiangmiao/auto-pairs',
  {
    -- Highlight Color codes
    'brenoprata10/nvim-highlight-colors',
    opts = {}
  },
  {
    -- OneDark theme
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        -- transparent = true
      }
      require('onedark').load()
    end
  },
  {
    -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    opts = {}
  },
  {
    -- Startup page
    "mhinz/vim-startify",
    config = function()
      local logo = {
        "┏━┓ ┏         ┓  ┏  •      ",
        "┃ ┃ ┃ ┏━┓ ┏━┓ ┗┓┏┛  ┓ ┏━┳━┓",
        "┛ ┗━┛ ┗━━ ┗━┛  ┗┛   ┗ ┗ ┗ ┗",
      }
      vim.g.startify_logo = logo
      vim.g.startify_custom_header = 'startify#center(g:startify_logo)'
    end
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = "\u{e0b9}", right = "\u{e0bb}" },
        section_separators = { left = "\u{e0b8}", right = "\u{e0ba}" },
      },
    },
  },
  {
    -- Code autocompletion plugin
    'neoclide/coc.nvim',
    branch = "release",
    config = function()
      vim.g.coc_global_extensions = {
        'coc-explorer',
        'coc-json',
        'coc-sumneko-lua',
        'coc-snippets'
      }
    end
  },
  {
    -- Indentation highlight plugin
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      exclude = { filetypes = { "startify" } },
    },
  },
  {
    -- Smart commenting plugin
    'numToStr/Comment.nvim',
    opts = {}
  },
  {
    -- Tabbed layout plugin
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          -- separator_style = "slant",
          offsets = {
            {
              filetype = "coc-explorer",
              text = " File Explorer",
              text_align = "left",
              seperator = true,
            }
          },
        }
      }
      vim.keymap.set("n", '<M-,>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
      vim.keymap.set("n", '<M-.>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
      vim.keymap.set("n", '<M-<>', '<Cmd>BufferLineMovePrev<CR>', { silent = true })
      vim.keymap.set("n", '<M->>', '<Cmd>BufferLineMoveNext<CR>', { silent = true })
      vim.keymap.set("n", '<leader>d', '<Cmd>bd<CR>', { silent = true, desc = "[D]elete buffer" })
    end
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
})

-- Show line number
vim.wo.number = true
-- Add padding to show signs next to line numbers
vim.wo.signcolumn = 'yes'

-- Sync clipboard between OS and Neovim
-- vim.o.clipboard = 'unnamedplus'

-- Enable indent on newlines
vim.o.breakindent = true

-- Ignore case when searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease updatetime
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Set colormode of the terminal
vim.o.terminguicolors = true


-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('n', "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- Open the file explorer
vim.keymap.set("n", "<leader>e", "<Cmd>CocCommand explorer<CR>", { desc = "File [E]xplorer" })

-- Save on Ctrl + S
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- Enter normal mode by 'jk' or 'ii' based on current mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set({ 'v', 't' }, "ii", "<Esc>")


-- Highlight the yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Additional CoC settings
-- Use Tab for trigger completion with characters ahead and navigate
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })


-- Use K to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
  group = "CocGroup",
  command = "silent call CocActionAsync('highlight')",
  desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
  group = "CocGroup",
  pattern = "typescript,json",
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = "Setup formatexpr specified filetype(s)."
})


vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

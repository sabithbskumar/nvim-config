call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

  " Themes
  Plug 'dracula/vim'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'navarasu/onedark.nvim'
  Plug 'shaunsingh/moonlight.nvim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

  " UI Elements (File tree, Tabs and Status line)
  Plug 'preservim/nerdtree'
  Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
  Plug 'nvim-lualine/lualine.nvim'
  " Plug 'romgrk/barbar.nvim'

  " Icons
  Plug 'ryanoasis/vim-devicons'
  Plug 'nvim-tree/nvim-web-devicons'
  " Plug 'kyazdani42/nvim-web-devicons'

  " Syntax Highlight and Autocompletion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'brenoprata10/nvim-highlight-colors'

  " Utils
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'mhinz/vim-startify'
  Plug 'jiangmiao/auto-pairs'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'wuelnerdotexe/vim-astro'
  Plug 'numToStr/Comment.nvim'

call plug#end()

if empty($TMUX)
  if has("nvim")
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if has("termguicolors")
    set termguicolors
  endif
endif

" Setup
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set nocompatible
set showmatch
set ignorecase
set hlsearch
set incsearch
set number
set wildmode=longest,list
set cc=80
filetype plugin indent on
syntax on

" Open new split panes to right and below
set splitright
set splitbelow

" Set leader key
let mapleader = "\<Space>"

" Turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" Nerdtree config
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusLine = ''

" Astro config
let g:astro_typescript = 'enable'

" Keymappings

" Ctrl + S to save
:nnoremap <C-s> :w<CR>
:inoremap <C-s> <Esc>:w<CR>a

" Move lines using down and up using  Alt j/k
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Press and jk to exit insert mode and visual mode.
inoremap jk <Esc>
vnoremap ii <Esc>
tmap ii <Esc>

" Nerdtree
nnoremap <silent><leader>n :NERDTreeFocus<CR>
nnoremap <silent><C-b> :NERDTreeToggle<CR>
nnoremap <silent><C-f> :NERDTreeFind<CR>

" Move to previous/next file Alt , and Alt .
nnoremap <silent><M-,> <Cmd>BufferLineCyclePrev<CR>
nnoremap <silent><M-.> <Cmd>BufferLineCycleNext<CR>
" Close buffer Space + d
nnoremap <silent><leader>d <Cmd>bd<CR>
" Re-order to previous/next Alt < and Alt >
nnoremap <silent><M-<> <Cmd>BufferLineMovePrev<CR>
nnoremap <silent><M->> <Cmd>BufferLineMoveNext<CR>

" Select suggestion using Enter
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()


" Code folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.


" Move up and down normally on wrapped lines
let s:wrapenabled = 0
function! ToggleWrap()
  set wrap nolist
  if s:wrapenabled
    set nolinebreak
    unmap j
    unmap k
    unmap 0
    unmap ^
    unmap $
    let s:wrapenabled = 0
  else
    set linebreak
    nnoremap j gj
    nnoremap k gk
    nnoremap 0 g0
    nnoremap ^ g^
    nnoremap $ g$
    vnoremap j gj
    vnoremap k gk
    vnoremap 0 g0
    vnoremap ^ g^
    vnoremap $ g$
    let s:wrapenabled = 1
  endif
endfunction
:call ToggleWrap()
map <leader>w :call ToggleWrap()<CR>


lua << END

require('onedark').setup {
  style = 'dark', -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
  transparent = false,  -- Transparent background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes.
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Toggle theme style ---
  toggle_style_key = "<leader>ts", -- Toggle theme style. "nil" to disable.
  toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle

  -- Code style ---
  -- italic, bold, underline, none
  -- Multiple style with comma seperated 'italic,bold'
  code_style = {
    comments  = 'none',
    keywords  = 'bold',
    functions = 'bold',
    strings   = 'none',
    variables = 'bold'
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },

}
require('onedark').load()

require("bufferline").setup {
  options = {
    separator_style = "slant",
    offsets = {
      {
        filetype = "nerdtree",
        text = " File Explorer",
        text_align = "left",
        highlight = "Directory",
        seperator = true,
      }
    },
  }
}

require('lualine').setup {
  options = {
    theme = 'onedark'
  }
}

require('Comment').setup()

-- IndentBlankline Config
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#282C35 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#252931 gui=nocombine]]

require("indent_blankline").setup {
  char = "",
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
}

-- Hex Color highlighter setup
require'colorizer'.setup()

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  sync_install = false,
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },
  
  -- Experimental
  indent = {
    enable = true
  },
  highlight = {
    enable = true,
      -- To disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
  },
}

END


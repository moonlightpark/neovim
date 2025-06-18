"----------------------------------------------------------------------------------
"-- config
"----------------------------------------------------------------------------------
" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

set hlsearch
set ignorecase

set nocompatible        " disable vi compatibility (emulation of old bugs)
set autoindent  " use indentation of previous line
set smartindent " use intelligent indentation for C

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
set number      " turn line numbers on
set showmatch   " highlight matching braces

set comments=sl:/*,mb:\ *,elx:\ */      " intelligent comments


"----------------------------------------------------------------------------------
"-- keyboard mappings
"----------------------------------------------------------------------------------
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" goto definition with F12
map <F12> <C-]>


"----------------------------------------------------------------------------------
"-- plugins
"----------------------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Or latest tag
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()


"----------------------------------------------------------------------------------
"-- plugin config
"----------------------------------------------------------------------------------

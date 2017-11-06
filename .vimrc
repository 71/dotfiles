" Vim config
let mapleader = ' '

set hidden
set history=1000
set mouse=a
set noshowmode

" Plugins
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/denite.nvim'
Plugin 'Shougo/echodoc.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'lambdalisue/lista.nvim'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'w0rp/ale'

Plugin 'rakr/vim-one'
Plugin 'baabelfish/nvim-nim'
Plugin 'sebastianmarkow/deoplete-rust'
Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype plugin indent on

" Oh, beautiful editor
set termguicolors
set background=dark

colorscheme one

" Plugin Config
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
let g:deoplete#sources#rust#rust_source_path = systemlist('rustc --print sysroot')[0] . '/lib/rustlib/src/rust/src'

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'

" Mapping
nnoremap #  :<C-u>Lista<CR>
nnoremap g# :<C-u>ListaCursorWord<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


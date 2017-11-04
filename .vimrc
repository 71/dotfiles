" Plugins
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/denite.nvim'
Plugin 'bling/vim-airline'
Plugin 'rakr/vim-one'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
Plugin 'baabelfish/nvim-nim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'w0rp/ale'
Plugin 'sebastianmarkow/deoplete-rust'
Plugin 'rust-lang/rust.vim'

call vundle#end()

filetype plugin indent on

set termguicolors
set history=1000

set background=dark
colorscheme one

" Plugin Config
let g:deoplete#sources#rust#racer_binary=system('which racer')
let g:deoplete#sources#rust#rust_source_path=system('rustc --print sysroot') + '/lib/rustlib/src/rust/src'

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='one'

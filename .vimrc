" Plugins
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/deoplete'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'baabelfish/nvim-nim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'junegunn/fzf'
Plugin 'shougo/denite.nvim'
Plugin 'w0rp/ale'
Plugin 'sebastianmarkow/deoplete-rust'

call vundle#end()

filetype plugin indent on

set history=1000

" Plugin Config
let g:deoplete#sources#rust#racer_binary=system('which racer')
let g:deoplete#sources#rust#rust_source_path=system('rustc --print sysroot') + '/lib/rustlib/src/rust/src'

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'easymotion/vim-easymotion'

call vundle#end()
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set scrolloff=4
set sidescrolloff=5

set formatoptions+=j
set number

set history=1000
set expandtab ts=2 sw=2 ai

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
Plugin 'neomake/neomake'
Plugin 'baabelfish/nvim-nim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

call vundle#end()
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set complete-=i

set scrolloff=4
set sidescrolloff=5

set formatoptions+=j
set number

set history=1000
set expandtab tabstop=2 shiftwidth=2 softtabstop=0 smarttab

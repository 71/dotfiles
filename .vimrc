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
Plugin 'Shougo/echodoc.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'easymotion/vim-easymotion'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'w0rp/ale'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'

Plugin 'rakr/vim-one'
Plugin 'sebastianmarkow/deoplete-rust'
Plugin 'rust-lang/rust.vim'
Plugin 'zchee/deoplete-jedi'
Plugin 'omnisharp/omnisharp-vim'

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

let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_server_type = 'roslyn'

" Mapping
nnoremap <leader>ff :<C-u>GFiles<CR>
nnoremap <leader>bb :<C-u>Buffers<CR>
nnoremap <leader>t :<C-u>BTags<CR>
nnoremap <leader>T :<C-u>Tags<CR>
nnoremap <leader>h :<C-u>Helptags<CR>
nnoremap <leader>m :<C-u>Marks<CR>
nnoremap <leader>f :<C-u>BLines<CR>
nnoremap <leader>F :<C-u>Lines<CR>
nnoremap <leader><leader> :<C-u>Commands<CR>

nnoremap <leader>bp :<C-u>bp<CR>
nnoremap <leader>bn :<C-u>bn<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


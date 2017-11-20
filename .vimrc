
" =====================================================================
" ===  VIM CONFIG =====================================================
" =====================================================================

let mapleader = ' '

set hidden
set history=1000
set mouse=a
set noshowmode
set autochdir

set nocompatible
filetype off

" =====================================================================
" ===  PLUGINS  =======================================================
" =====================================================================

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'

Plug 'rakr/vim-one'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'rust-lang/rust.vim'
Plug 'zchee/deoplete-jedi'
Plug 'omnisharp/omnisharp-vim'

call plug#end()


" =====================================================================
" ===  VIM LOOK  ======================================================
" =====================================================================

filetype plugin indent on

set termguicolors
set background=dark

colorscheme one


" =====================================================================
" ===  PLUGINS CONFIG  ================================================
" =====================================================================

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary = systemlist('which racer')[0]
let g:deoplete#sources#rust#rust_source_path = systemlist('rustc --print sysroot')[0] . '/lib/rustlib/src/rust/src'

" Airline
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'

" OmniSharp
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_server_type = 'roslyn'


" =====================================================================
" ===  MAPPING  =======================================================
" =====================================================================

" fzf.vim
nnoremap <leader>FF :<C-u>Files<CR>
nnoremap <leader>ff :<C-u>GFiles<CR>
nnoremap <leader>bb :<C-u>Buffers<CR>
nnoremap <leader>t :<C-u>BTags<CR>
nnoremap <leader>T :<C-u>Tags<CR>
nnoremap <leader>h :<C-u>Helptags<CR>
nnoremap <leader>m :<C-u>Marks<CR>
nnoremap <leader>l :<C-u>BLines<CR>
nnoremap <leader>L :<C-u>Lines<CR>
nnoremap <leader>c :<C-u>Commands<CR>

" vim
nnoremap <leader>bp :<C-u>bp<CR>
nnoremap <leader>bn :<C-u>bn<CR>
nnoremap <leader>bd :<C-u>bd<CR>

" ALE
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" =====================================================================
" ===  FILETYPE-SPECIFIC  =============================================
" =====================================================================

" CSharp
au FileType cs
  \ setlocal ts=4 sw=4


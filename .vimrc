
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
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'severin-lemaignan/vim-minimap'
Plug 'danro/rename.vim'
Plug 'tomtom/tcomment_vim'

Plug 'rakr/vim-one'
Plug 'rhysd/vim-llvm'
" Plug 'sebastianmarkow/deoplete-rust'
" Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
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

" Minimap
let g:minimap_toggle = '<leader>mm'


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

" EasyMotion / incsearch
map / <Plug>(incsearch-easymotion-/)
map ? <Plug>(incsearch-easymotion-?)
map g/ <Plug>(incsearch-easymotion-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" tcomment
map ; <Plug>TComment


" =====================================================================
" ===  FILETYPE-SPECIFIC  =============================================
" =====================================================================

" CSharp
au FileType cs
  \ setlocal ts=4 sw=4


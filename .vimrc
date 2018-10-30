
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

" If vim-plug has not been downloaded yet, do it now
let plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
let plug_repo = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(plug_path))
  execute 'silent !curl -fLo ' . plug_path . ' --create-dirs ' . plug_repo

  autocmd VimEnter * PlugInstall | source '~/.vimrc'
endif

" Load all plugins
call plug#begin('~/.local/share/nvim/plugged')

" Common plugins
Plug 'bling/vim-airline'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'severin-lemaignan/vim-minimap'
Plug 'danro/rename.vim'
Plug 'tomtom/tcomment_vim'
Plug 'idanarye/vim-vebugger'
Plug 'rakr/vim-one'
Plug 'LnL7/vim-nix'
Plug 'maralla/completor.vim'

" Optional plugins (depends on computer and/or mood)
" Plug 'rhysd/vim-llvm'
" Plug 'rust-lang/rust.vim'
" Plug 'cespare/vim-toml'
" Plug 'zchee/deoplete-jedi'

call plug#end()


" =====================================================================
" ===  VIM LOOK  ======================================================
" =====================================================================

filetype plugin indent on

set termguicolors
set background=dark
set scrolloff=8

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

" ALE
" let g:ale_linters = { 'rust': ['cargo'] }
" let g:ale_rust_rls_executable = '~/rls/target/debug/rls'


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

" Save current file with sudo using :W
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command WQ :execute ':silent w !sudo tee % > /dev/null' | :execute ':silent q'

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


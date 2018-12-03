let g:rcdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" =====================================================================
" ===  PREFERENCES ====================================================
" =====================================================================

" Leader
let mapleader = " "

" Common options
set hidden
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=200
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set scrolloff=8
set sidescrolloff=12
set noshowmode
set autochdir

set nocompatible

" Sorry
set mouse=a

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Numbers
set number
set numberwidth=3

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

" Load local configuration (not shared between computers)
exe 'source' (g:rcdir . '/local.vim')


augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


" =====================================================================
" ===  PLUGINS  =======================================================
" =====================================================================

" If vim-plug has not been downloaded yet, do it now
let plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
let plug_repo = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if empty(glob(plug_path))
  exe 'silent !curl -fLo ' . plug_path . ' --create-dirs ' . plug_repo

  autocmd VimEnter * PlugInstall | source expand('%:p')
endif


" Load all plugins
call plug#begin('~/.local/share/nvim/plugged')

for f in split(glob(g:rcdir . '/plugins/*.vim'), '\n')
  exe 'source' f
endfor

call plug#end()


" =====================================================================
" ===  OTHER CONFIG ===================================================
" =====================================================================

" Language specific config
exe 'source' (g:rcdir . '/languages.vim')

" Keys
exe 'source' (g:rcdir . '/keys.vim')

" Local config
if filereadable($HOME . "/.vimrc")
  source ~/.vimrc
endif

" Deoplete
let g:deoplete#enable_at_startup = 1

" Airline
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'

" Minimap
let g:minimap_toggle = '<leader>mm'


" Plugins
Plug 'bling/vim-airline'
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'severin-lemaignan/vim-minimap'
Plug 'danro/rename.vim'
Plug 'tomtom/tcomment_vim'
Plug 'rakr/vim-one'

" Less necessary / bigger plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'idanarye/vim-vebugger'
Plug 'LnL7/vim-nix'

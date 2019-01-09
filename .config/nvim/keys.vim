" vim
nnoremap <leader>bp :<C-u>bp<CR>
nnoremap <leader>bn :<C-u>bn<CR>
nnoremap <leader>bd :<C-u>bd<CR>

" Switch backtick and quote
noremap ' `
noremap ` '

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Save current file with sudo using :W
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :execute ':silent q'

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>


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

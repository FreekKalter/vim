" author: Freek Kalter

" Forget being compatible with good ol' vi
set nocompatible

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

" Turn on that syntax highlighting
syntax on

" Why is this not a default
set hidden

" higlight search pattern
set hlsearch

" Incrementally match the search
set incsearch

" At least let yourself know what mode you're in
set showmode

" set dollar sign at end of what your changing
set cpoptions+=$

" Tabstops are 4 spaces
set tabstop=3
set shiftwidth=3
set expandtab
set autoindent

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" set the search scan to wrap lines
set wrapscan

" set the search scan so that it ignores case when the search is all lower
" case but recognizes uppercase if it's specified
set ignorecase
set smartcase

" set the forward slash to be the slash of note.  Backslashes suck
set shellslash

" Make command line two lines high
set ch=2

" set linenumbers
set number

" set visual bell -- i hate that damned beeping
set vb

" virtual edit: move the cursor on invalid empty space
set virtualedit=all

" setting syntax mode for some file-extensions

autocmd BufNewFile,BufRead *.pl set formatprg=astyle\ -A7s2x
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" colorscheme
colorscheme desert

" get rid of the silly characters in window separators
set fillchars=""

" stop some plugins from loading
let loaded_showmarks = 1

" set wildmenu on
set wildmenu

" Set the status line the way i like it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" set the gui options the way I like
set guioptions=ac

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,sb :wincmd p<CR>
noremap <silent> <C-F9>  :vertical resize -10<CR>
noremap <silent> <C-F10> :resize +10<CR>
noremap <silent> <C-F11> :resize -10<CR>
noremap <silent> <C-F12> :vertical resize +10<CR>
noremap <silent> ,s8 :vertical resize 83<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>
noremap <silent> ,L <C-W>L
noremap <silent> ,K <C-W>K
noremap <silent> ,H <C-W>H
noremap <silent> ,J <C-W>J
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>
:nmap ,:leftabove vert sbn<CR>
:nmap ,:rightbelow vert sbn<CR>


" author: Freek Kalter
" based on Derek Wyats original vimrc (and awsome videos)

" Forget being compatible with good ol' vi
set nocompatible

" call pathogen to mangage runtime paths
call pathogen#infect()

" Turn on that syntax highlighting
syntax on

" Support 256 colors
set t_Co=256


" colorscheme
colorscheme molokai

if has('gui_running')

   " set font
   if has("gui_gtk2")
      set guifont=Envy\ Code\ R\ 10
   elseif has("win32")
      au GUIEnter * simalt ~m
      set guifont=Envy\ Code\ R\ Italic:h10 
   elseif has('mac')
      set guifont=inconsolata:h13,\ Envy\ Code\ R:h13
   endif
else
   "set terminal font
endif

" Get that filetype stuff happening
filetype on
set complete-=i

"NERDTree options
"let loaded_nerd_tree=1
"let NERDTreeQuitOnOpen=1

filetype plugin on
filetype indent on

" Why is this not a default
set hidden

" higlight search pattern
set hlsearch

" set temp directory to create swap files, windows needs this
set directory+=,~/tmp,$TMP

" Incrementally match the search
set incsearch

" At least let yourself know what mode you're in
set showmode

" set dollar sign at end of what your changing
set cpoptions+=$

" Tabstops are 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

"custom highlighting for some files

" clear buffers created by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" get rid of the silly characters in window separators
set fillchars=""

" set wildmenu on
set wildmenu

"define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy

"run :Tidy on entire buffer and return cursor to (approximate) original position"
fun! DoTidy()
    let Pos = line2byte( line( "." ) ) 
    :Tidy
    exe "goto " . Pos 
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <F4> :call DoTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <F4> :Tidy<CR>

" Set the status line the way i like it
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %{fugitive#statusline()}

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Indicates a fast terminal connection. Quick redraw of screen.
set ttyfast

" set line numbers relative to current line (helps with going up n lines) 
set relativenumber

" apply global substitutions on lines
set gdefault

" save all files on focus lost (only gui) and switching buffers
au FocusLost * :wa
set autowriteall

" automatically reload vimrc when it's saved
augroup AutoReloadVimRC
  au!
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" set the gui options the way I like
set guioptions=ac

" Maps to make handling windows a bit easier
set pastetoggle=<F2>

let mapleader = ","

" pane switcing
noremap <silent> <C-h> :wincmd h<CR>
noremap <silent> <C-j> :wincmd j<CR>
noremap <silent> <C-k> :wincmd k<CR>
noremap <silent> <C-l> :wincmd l<CR>

" pave moving 
noremap <silent> <leader>L <C-W>L
noremap <silent> <leader>K <C-W>K
noremap <silent> <leader>H <C-W>H
noremap <silent> <leader>J <C-W>J

"pane resizing 
noremap <silent> <leader>q :vertical resize +10<CR>
noremap <silent> <leader>w :vertical resize -10<CR>

" pane closing with leader key
noremap <silent> <leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
noremap <silent> <leader>cc :close<CR>
noremap <silent> <leader>cw :cclose<CR>

noremap <silent> <leader>sb :wincmd p<CR>
noremap <silent> <C-7> <C-W>>
noremap <silent> <C-8> <C-W>+
noremap <silent> <C-9> <C-W>+
noremap <silent> <C-0> <C-W>>
:nmap <leader>:leftabove vert sbn<CR>
:nmap <leader>:rightbelow vert sbn<CR>

"remove higlight on space in normal mode
nmap <SPACE> <SPACE>:noh<CR>

" even faster access to ack
nnoremap <leader>a :Ack 

nnoremap <leader>m :silent make\|redraw!\|cc<CR>
" open .vimrc in splitwindow 
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" make ; do the same a : (saves a shift keystroke entering normal-mode)
" nnoremap ; :

" map jk in insert-mode to esc key
:inoremap jk <Esc>

" map jk in command-mode to esc key
cnoremap jk <C-c>

" use tab to find matching brackets
nnoremap <tab> %
vnoremap <tab> %

let g:syntastic_go_checker="gofmt"
nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeShowBookmarks=1

"NERDTREE file filters
let NERDTreeIgnore=['^NTUSER\.DAT', '\~$'] 

"Refresh firefox on saving website related documents
autocmd BufWriteCmd *.html,*.css,*.gtpl,*.tt,*.tt2,*.js,*.mkdn  :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
          \ vimXo = content.window.pageXOffset;
          \ BrowserReload();
          \ content.window.scrollTo(vimXo,vimYo);
          \ repl.quit();'  |
          \ nc -w 1 localhost 4242 2>&1 > /dev/null
  endif
endfunction

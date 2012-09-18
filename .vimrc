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
colorscheme jellybeans

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
au BufNewFile,BufRead *.tt set filetype=tt2html
au BufNewFile,BufRead *.tt2 set filetype=tt2html

au BufNewFile,BufRead *.less set filetype=css
au BufNewFile,BufRead *.pl.tdy set filetype=perl

" clear buffers created by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" get rid of the silly characters in window separators
set fillchars=""

" set wildmenu on
set wildmenu

" Set the status line the way i like it
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %{fugitive#statusline()}

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" set the gui options the way I like
set guioptions=ac

" Maps to make handling windows a bit easier
set pastetoggle=<F2>
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

"remove higlight on space in normal mode
nmap <SPACE> <SPACE>:noh<CR>

"map jk in insert-mode to esc key
:imap jk <Esc>

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

let mapleader = ","
nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeShowBookmarks=1

"NERDTREE file filters
let NERDTreeIgnore=['^NTUSER\.DAT', '\~$'] 

"Refresh firefox on saving website related documents
autocmd BufWriteCmd *.html,*.css,*.gtpl :call Refresh_firefox()
function! Refresh_firefox()
  if &modified
    write
    silent !echo  'vimYo = content.window.pageYOffset;
                 \ vimXo = content.window.pageXOffset;
                 \ BrowserReload();
                 \ content.window.scrollTo(vimXo,vimYo);
                 \ repl.quit();'  |
                 \ nc localhost 4242 2>&1 > /dev/null
  endif
endfunction

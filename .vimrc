" Copyright (c) 2013 Freek Kalter
" Licensed under revised BSD license. See LICENSE file.
"
" based on Derek Wyats original vimrc (and awsome videos)


" Forget being compatible with good ol' vi
set nocompatible

" call pathogen to mangage runtime paths
call pathogen#infect()

" Turn on that syntax highlighting
syntax enable

" syntastic settings
let g:syntastic_auto_loc_list=1 
let g:syntastic_auto_jump=1 
let g:syntastic_perl_lib_path = './lib'

" colorscheme
set background=dark
autocmd VimEnter * :SetColors codeschool jellybeans grb256 distinguishd

if has('gui_running')
    colorscheme codeschool
    set guifont=DejaVu\ Sans\ Mono\ 10
     " maximize window when vim is fully loaded otherwise some other comands
     " overrides these values
    autocmd VimEnter * set lines=60 columns=239  

else
    set t_Co=256
    colorscheme molokai
endif

let os = substitute(system('uname'), "\n", "", "")
let hostname = substitute(system('hostname'), "\n", "", "")
   
if hostname == "London" && ! has('gui_running')
    au InsertEnter * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_UNDERLINE/' ~/.config/Terminal/terminalrc"
    au InsertLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_UNDERLINE/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/Terminal/terminalrc"
    au VimLeave * silent execute "!sed -i.bak -e 's/TERMINAL_CURSOR_SHAPE_UNDERLINE/TERMINAL_CURSOR_SHAPE_BLOCK/' ~/.config/Terminal/terminalrc"
endif

set encoding=utf-8

" map jk in insert-/command-mode to esc key
:inoremap jk <Esc>
cnoremap jk <C-c>

" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
set completeopt=longest,menuone
" let g:SuperTabLongestHighlight = 1
" set complete=.,b,u,]

let g:sparkupNextMapping = '<c-x>'


" Why is this not a default (allow hidden buffers)
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

" highlight current line
set cursorline

" set visual bell -- i hate that damned beeping
set vb

" virtual edit: move the cursor on invalid empty space
set virtualedit=all

" clear buffers created by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

" get rid of the silly characters in window separators
set fillchars=""

" set wildmenu on
set wildmenu
set wildmode=longest,list

" define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy

" run :Tidy on entire buffer and return cursor to (approximate) original position"
fun! DoTidy()
    let Pos = line2byte( line( "." ) ) 
    :Tidy
    exe "goto " . Pos 
endfun

" shortcut for normal/visual mode to run on entire buffer then return to current line"
au Filetype perl nmap <F4> :call DoTidy()<CR>
au Filetype perl vmap <F4> :Tidy<CR>

" Set the status line the way i like it
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %{fugitive#statusline()}

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Indicates a fast terminal connection. Quick redraw of screen.
set ttyfast

" set line numbers relative to current line (helps with going up n lines) 
" set relativenumber

" apply global substitutions on lines
set gdefault

" save all files on focus lost (only gui) and switching buffers
" au FocusLost * :wa
" set autowriteall

let mapleader = ";"

" open .vimrc in splitwindow 
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" automatically reload vimrc when it's saved
augroup AutoReloadVimRC
  au!
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" set the gui options the way I like
set guioptions=ac
set mouse-=a

" use this to paste indented code 
set pastetoggle=<F2>

" Maps to make handling windows a bit easier

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

" pane resizing 
noremap <silent> <leader>l :vertical resize +10<CR>
noremap <silent> <leader>h :vertical resize -10<CR>
noremap <silent> <leader>j :resize +10<CR>
noremap <silent> <leader>k :resize -10<CR>

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

" change working dir to dir of current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" AWSOME!!!!
" mapping to run last run command in last active window
" so during hacking in vim, simply ;rl and BAM file saved and run in next tmux
" pane.
noremap <leader>rl :w<Bar>execute 'silent !tmux send-keys -t .-1 Up C-m'<Bar>redraw!<CR>

" remove higlight on space in normal mode 
nmap <SPACE> <SPACE>:noh<CR>

" even faster access to ack
nnoremap <leader>a :Ack 

nnoremap <leader>m :silent make\|redraw!\|cc<CR>

" keep cursor in position when joining lines
nnoremap J mzJ`z

" searching/scrolling keeps focus in the middle of the screen 
" nnoremap n nzz
" nnoremap } }zz
set scrolloff=5

" make moving up and down more intuitive with wrapped lines
nnoremap j gj
nnoremap k gk

" writing a file as root
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" use tab to find matching brackets
nnoremap <tab> %
vnoremap <tab> %

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X>      "+x
vnoremap <S-Del>    "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C>      "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>	"+gP
" NERDTree options
" let loaded_nerd_tree=1
" let NERDTreeQuitOnOpen=1

let g:syntastic_go_checker="gofmt"
nmap <leader>n :e.<cr>
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=1

" NERDTREE file filters
let NERDTreeIgnore=['^NTUSER\.DAT', '\~$'] 

" e flag is to surpress error message if pattern is not found
autocmd FileType vim autocmd BufWritePre <buffer> :%s/^"\(\w\)/" \1/e
autocmd FileType zsh autocmd BufWritePre <buffer> :%s/^#\(\w\)/# \1/e
autocmd FileType go autocmd BufWritePre <buffer> :%s/^\/\/\(\w\)/\/\/ \1/e

autocmd FileType c,perl,sh autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup Go
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
augroup END
    

" Refresh firefox on saving website related documents
" Requires mozrepl firefox plugin
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

ab rigth right
ab rigth_ right_
ab _rigth _right

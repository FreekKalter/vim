" Copyright (c) 2013 Freek Kalter
" Licensed under revised BSD license. See LICENSE file.
"
" based on Derek Wyats original vimrc (and awsome videos)

" Forget being compatible with good ol' vi
set nocompatible
" call pathogen to mangage runtime paths
call pathogen#infect()

" Basic vim settings {{{
" Turn on that syntax highlighting
syntax enable
" Get that filetype stuff happening
filetype on
filetype plugin on
filetype indent on

set encoding=utf-8
" Why is this not a default (allow hidden buffers)
set hidden
" higlight search pattern
set hlsearch
" set temp directory to create swap files, windows needs this
set directory+=,~/tmp,$TMP
set incsearch
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

" Set the status line the way i like it
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %{fugitive#statusline()}

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Indicates a fast terminal connection. Quick redraw of screen.
set ttyfast
" apply global substitutions on lines
set gdefault
" searching/scrolling keeps focus in the middle of the screen 
set scrolloff=5
" set the gui options the way I like
set guioptions=ac
set mouse-=a

" get rid of the silly characters in window separators
set fillchars=""

" wild menu {{{

" set wildmenu on
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.snv   " Version control

" }}}
" Some mappings wich should be default {{{
" keep cursor in position when joining lines
nnoremap J mzJ`z

" make moving up and down more intuitive with wrapped lines
nnoremap j gj
nnoremap k gk

" use this to paste indented code 
set pastetoggle=<F2>
" }}}
" }}}
" Syntastic {{{

let g:syntastic_auto_loc_list=1 
let g:syntastic_auto_jump=1 
let g:syntastic_perl_lib_path = './lib'
let g:syntastic_go_checker="gofmt"

" }}}

" Visual stuff {{{
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
" }}}

" map jk in insert-/command-mode to esc key
inoremap jk <Esc>
cnoremap jk <C-c>

let mapleader = ";"

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
set completeopt=longest,menuone
" let g:SuperTabLongestHighlight = 1
" set complete=.,b,u,]

let g:sparkupNextMapping = '<c-x>'

" clear buffers created by fugitive
augroup fugitive
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END


" Pulse Line {{{

function! s:Pulse() " {{{
    let current_window = winnr()
    windo set nocursorline
    execute current_window . 'wincmd w'
    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_guibg = matchlist( old_hi, 'guibg=\(#[0-9a-zA-Z]\{6}\)') 
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    if has('gui_running')
        for i in range(5)
            silent execute "hi CursorLine guibg=Red"
            redraw
            sleep 16m
            
            silent execute "hi CursorLine guibg=". old_guibg[1]
            redraw
            sleep 16m
        endfor
    else
        let steps = 9
        let width = 1
        let start = width
        let end = steps * width
        let color = 1

        for i in range(start, end, width)
            execute "hi CursorLine ctermbg=" . (color + i)
            redraw
            sleep 6m
        endfor
        for i in range(end, start, -1 * width)
            execute "hi CursorLine ctermbg=" . (color + i)
            redraw
            sleep 6m
        endfor
    endif

    execute 'hi ' . old_hi
endfunction " }}}
command! -nargs=0 Pulse call s:Pulse()

" }}}
nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy

" run :Tidy on entire buffer and return cursor to (approximate) original position"
fun! DoTidy()
    let Pos = line2byte( line( "." ) ) 
    :Tidy
    exe "goto " . Pos 
endfun

" shortcut for normal/visual mode to run on entire buffer then return to current line"
augroup perl_tidy
    au Filetype perl nmap <F4> :call DoTidy()<CR>
    au Filetype perl vmap <F4> :Tidy<CR>
augroup END


" open .vimrc in splitwindow 
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>


" Moving/switching/resizing windows/panes around {{{

" pane switcing
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" pave moving 
nnoremap <silent> <leader>L <C-W>L
nnoremap <silent> <leader>K <C-W>K
nnoremap <silent> <leader>H <C-W>H
nnoremap <silent> <leader>J <C-W>J

" pane resizing 
nnoremap <silent> <leader>l :vertical resize +10<CR>
nnoremap <silent> <leader>h :vertical resize -10<CR>
nnoremap <silent> <leader>j :resize +10<CR>
nnoremap <silent> <leader>k :resize -10<CR>

" pane closing with leader key
nnoremap <silent> <leader>cj :wincmd j<CR>:close<CR>
nnoremap <silent> <leader>ck :wincmd k<CR>:close<CR>
nnoremap <silent> <leader>ch :wincmd h<CR>:close<CR>
nnoremap <silent> <leader>cl :wincmd l<CR>:close<CR>
nnoremap <silent> <leader>cc :close<CR>
nnoremap <silent> <leader>cw :cclose<CR>

nnoremap <silent> <leader>p :wincmd p<CR>
nnoremap <silent> <leader>s :b#<CR>

" }}}
" change working dir to dir of current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" AWSOME!!!!
" mapping to run command in active tmux pane
" so during hacking in vim, simply hit ;rl and BAM file saved and run in active tmux
" pane.
nnoremap <leader>rl :w<Bar>execute 'silent !tmux send-keys Up C-m'<Bar>redraw!<CR>
inoremap <leader>rl <esc>:w<Bar>execute 'silent !tmux send-keys Up C-m'<Bar>redraw!<CR>


" even faster access to ack
nnoremap <leader>a :Ack<space>

nnoremap <leader>m :silent make\|redraw!\|cc<CR>


" writing a file as root
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" use tab to find matching brackets
nnoremap <tab> %
vnoremap <tab> %

" Copy/Pasing with system clipboard {{{
" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X>      "+x
vnoremap <S-Del>    "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C>      "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>	"+gP

" }}}

" fold mappings
nnoremap <space> za

" clear search higlight
nnoremap <bs> :nohlsearch<cr>

" NERDTree options
" let loaded_nerd_tree=1
" let NERDTreeQuitOnOpen=1

nmap <leader>n :e.<cr>
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=1

" NERDTREE file filters
let NERDTreeIgnore=['^NTUSER\.DAT', '\~$'] 

" clean comments, space after comment char
augroup clean_comments
    " e flag is to surpress error message if pattern is not found
    autocmd!
    autocmd FileType vim autocmd BufWritePre <buffer> :%s/^"\(\w\)/" \1/e
    autocmd FileType zsh autocmd BufWritePre <buffer> :%s/^#\(\w\)/# \2/e
    "autocmd FileType go autocmd BufWritePre <buffer> :%s/^\/\/\(\w\)/\/\/ \2/e
augroup end

" upercase a word 
nnoremap <leader>u viw~

" clean whitespace at end of lines
augroup whitespace
    au!
    autocmd FileType c,perl,sh autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup end

augroup Go
    au!
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

" Vim {{{

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au BufWritePost .vimrc source $MYVIMRC
augroup END

" }}}
" Abbrevations {{{

ab rigth right
ab rigth_ right_
ab _rigth _right
ab frk Freek Kalter
ab ccopy Copyright (c) 2013 Freek Kalter
ab wbs kalteronline.org

" }}}

" Copyright (c) 2013 Freek Kalter
" Licensed under revised BSD license. See LICENSE file.
"
" based on Derek Wyats original vimrc (and awsome videos)
" lots of inspiration (read copied) from Steve Losh

" Preamble {{{

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype on
" call pathogen to mangage runtime paths
filetype indent plugin on
" Forget being compatible with good ol' vi
set nocompatible

" }}}
" Basic vim settings {{{

" Turn on that syntax highlighting
set t_Co=256
syntax enable

set encoding=utf-8
set lazyredraw
set history=1000
" always show status line
set laststatus=2
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
set smarttab
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
set fillchars=diff:⣿,vert:│
set autowrite
set autoread
set autochdir
set title

set colorcolumn=+1
set sessionoptions+=resize,winpos,globals
set viewoptions+=cursor,folds,options,slash,unix
" Save global vars in between startups
set viminfo+=!
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
" set notimeout
" set ttimeout
" set ttimeoutlen=10
"
"set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,tags

" Backups {{{
set backup
set noswapfile

set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap// " swap files

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}

" wild menu {{{

" set wildmenu on
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.snv   " Version control

" }}}
" }}}
" Syntastic {{{

let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=1
"let g:syntastic_perl_lib_path = './lib'
"let g:syntastic_perl_checkers = ['perl']
let g:syntastic_go_checkers = ['go']


" }}}
" Visual stuff {{{
" colorscheme
set background=dark
" <F8> cycle throug light scheme     <F9> cycle throug dark schemes
let g:lightColorCarousel = [ 'pyte' ,  'ironman' , 'summerfruit256' ,
            \ 'simpleandfriendly' ]
let g:darkColorCarousel = [ 'codeschool' , 'jellybeans' , 'grb256' ,
            \'distinguished' , 'molokai' ]
let g:terminalDarkColorCarousel = [ 'grb256' , 'molokai' , 'jellybeans' ]
let g:terminalLightColorCarousel = [ 'summerfruit256' ]

let s:fontCarousel = [ 'Source\ Code\ Pro\ Semibold\ 10' ,
            \'DejaVu\ Sans\ \Mono\ 10',
            \'Ubuntu\ Mono\ 12',
            \'Source\ Code\ Pro\ Semibold\ 11',
            \'Anonymous\ Pro\ Bold\ 12',
            \'Inconsolata\ 12',
            \'Droid\ Sans\ Mono\ 10',
            \'Monofur\ 14',]

if has('gui_running')
    if has('gui_macvim')
        set guifont=Menlo:h12
    endif
    " maximize window when vim is fully loaded otherwise some other comands
    " overrides these values
    autocmd VimEnter * set lines=60 columns=239
endif

" set the colorscheme used in last session
autocmd VimEnter * execute 'colorscheme ' . g:CURRENTCOLOR
autocmd VimEnter * execute 'set guifont=' . g:CURRENTFONT
" keep current colorscheme when reloading vimrc
if exists("g:CURRENTCOLOR") == 1
    execute 'colorscheme ' . g:CURRENTCOLOR
endif

if exists("g:CURRENTFONT") == 1
    execute 'set guifont=' . g:CURRENTFONT
endif
"set antialias


let s:currentFont = -1
function! FontCarousel()
    " Update counter
    if s:currentFont == -1
        let s:currentFont = 0
    else
        let s:currentFont += 1
    endif

    " cylce counter
    if s:currentFont > len(s:fontCarousel)-1
        let s:currentFont = 0
    endif

    " set font
    execute 'set guifont=' . s:fontCarousel[s:currentFont]
    redraw
    let g:CURRENTFONT = s:fontCarousel[s:currentFont]
    echo g:CURRENTFONT
endfunction

let os = substitute(system('uname'), "\n", "", "")
let hostname = substitute(system('hostname'), "\n", "", "")

"if hostname == "London" && ! has('gui_running')
    "au InsertEnter * silent execute "!sed -i.bak -e
                "\'s/TERMINAL_CURSOR_SHAPE_BLOCK/TERMINAL_CURSOR_SHAPE_UNDERLINE/'
                "\~/.config/Terminal/terminalrc"
    "au InsertLeave * silent execute "!sed -i.bak -e
                "\'s/TERMINAL_CURSOR_SHAPE_UNDERLINE/TERMINAL_CURSOR_SHAPE_BLOCK/'
                "\~/.config/Terminal/terminalrc"
    "au VimLeave * silent execute "!sed -i.bak -e
                "\'s/TERMINAL_CURSOR_SHAPE_UNDERLINE/TERMINAL_CURSOR_SHAPE_BLOCK/'
                "\~/.config/Terminal/terminalrc"
"endif
" }}}
" Mappings {{{

" Some mappings wich should be default {{{
" keep cursor in position when joining lines
nnoremap J mzJ`z

" Join line above current line behind current line
" mainly for joining short comments above a line
nnoremap JJ mzk^dg_j$lpkdd`z
" make moving up and down more intuitive with wrapped lines
nnoremap j gj
nnoremap k gk

" use this to paste indented code
set pastetoggle=<F2>

nnoremap Y y$

" }}}

" map jk in insert-/command-mode to esc key
inoremap jk <Esc>
cnoremap jk <C-c>

let mapleader = ";"
let maplocalleader = ","

" Use sane regex matching (magic)
nnoremap / /\v
vnoremap / /\v

" Open help in vertical split
command! -nargs=* -complete=help H vertical topleft help <args><cr>:vertical resize 80

nnoremap ! :Clam<space>
vnoremap ! :ClamVisual<space>

" change working dir to dir of current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" AWSOME!!!!
" mapping to run command in active tmux pane
" so during hacking in vim, simply hit ;rl and BAM file saved and run in active tmux
" pane.
nnoremap <leader>rl :w<Bar>execute 'silent !tmux send-keys Up C-m'<Bar>redraw!<CR>
inoremap <leader>rl <esc>:w<Bar>execute 'silent !tmux send-keys Up C-m'<Bar>redraw!<CR>

nnoremap Q <nop>

nnoremap , `
nnoremap ,, `'

" even faster access to ack
nnoremap <leader>a :Ack<space>

nnoremap <leader>m :silent make\|redraw!\|cc<CR>

" fold mappings
nnoremap <space> za

" clear search higlight
nnoremap <bs> :nohlsearch<cr>

" upercase a word
nnoremap <leader>u viw~

" Create empty line above/below current from normal mode
nnoremap <leader>o mzo<esc>`z
nnoremap <leader>O mzO<esc>`z

" toggle between help and text filetype
nnoremap <leader>hh :call ToggleHelpSyntax()<cr>

function! ToggleHelpSyntax ()
    if &filetype == 'help'
        echom 'help to text'
        set filetype=text
    elseif &filetype == 'text'
        echom 'text to help '
        set filetype=help
    endif
endfunction

" colorCarousel
noremap <F8> :call ColorCarouselNextColor('light')<cr>
noremap <F9> :call ColorCarouselNextColor('dark')<cr>
" fontCarousel
noremap <F7> :call FontCarousel()<cr>

" writing a file as root
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" saving with ctrl-s
inoremap <C-s> <esc>:w<CR>
nnoremap <C-s> :w<CR>

nnoremap <silent> <F6> :TagbarToggle<CR>

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "Ack " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction

" }}}
" Fugitive {{{

" clear buffers created by fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>

" }}}
" Completion {{{
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:SuperTabNoCompleteAfter = ['^', ',', '\s', '(' ]
let g:SuperTabLongestHighlight=1
let g:SuperTabLongestEnhanced=1
set completeopt=menu,menuone,longest

" }}}
" Pulse Line {{{

nnoremap <c-z> mzzMzvzz15<c-e>`z:Pulse<cr>

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
" Highlight Word {{{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily. You can search for it, but that only
" gives you one color of highlighting. Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.
" Default Highlights {{{
autocmd VimEnter * call HighlightInit()
function! HighlightInit()
    hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
    hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
    hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
    hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
    hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
    hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
endfunction
" }}}
function! HiInterestingWord(n) " {{{
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID. Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction " }}}
" Mappings {{{
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
nnoremap <silent> <leader>C :call clearmatches()<cr>
" }}}
" }}}
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
" Perl stuff {{{

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
    au!
    au Filetype perl nmap <F4> :call DoTidy()<CR>
    au Filetype perl vmap <F4> :Tidy<CR>
augroup END

" }}}
" Moving/switching/resizing windows/panes around {{{

" pane switcing
"nnoremap <silent> <C-h> :wincmd h<CR>
"nnoremap <silent> <C-j> :wincmd j<CR>
"nnoremap <silent> <C-k> :wincmd k<CR>
"nnoremap <silent> <C-l> :wincmd l<CR>

"inoremap <silent> <C-h> <esc>:wincmd h<CR>
"inoremap <silent> <C-j> <esc>:wincmd j<CR>
"inoremap <silent> <C-k> <esc>:wincmd k<CR>
"inoremap <silent> <C-l> <esc>:wincmd l<CR>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

inoremap <silent> <C-h> :TmuxNavigateLeft<cr>
inoremap <silent> <C-j> :TmuxNavigateDown<cr>
inoremap <silent> <C-k> :TmuxNavigateUp<cr>
inoremap <silent> <C-l> :TmuxNavigateRight<cr>
inoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

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

" quick switch between last active pane
nnoremap <silent> <leader>q :wincmd p<CR>
nnoremap <silent> <leader>s :b#<CR>

" }}}
" Copy/Pasing with system clipboard {{{

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C>      "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
nnoremap <C-B>		"+gP
inoremap <C-B>		<esc>"+gpi

" }}}
" NERDTree {{{
" let loaded_nerd_tree=1
" let NERDTreeQuitOnOpen=1

nmap <leader>n :e.<cr>
let NERDTreeShowBookmarks=1
let NERDTreeHijackNetrw=1

" NERDTREE file filters
let NERDTreeIgnore=['^NTUSER\.DAT', '\~$']

" }}}
" Tidying up {{{
" clean comments, space after comment char
augroup clean_comments
    " e flag is to surpress error message if pattern is not found
    autocmd!
    "autocmd FileType vim autocmd BufWritePre <buffer> :%s/\v^"(\S)/" \1/e
    autocmd FileType zsh autocmd BufWritePre <buffer> :%s/\v^(#+)([^#[:space:]])/\1 \2/e
augroup end

" clean whitespace at end of lines
augroup whitespace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup end

nnoremap <localleader>c :Fmt<cr>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

augroup Go
    autocmd!
    autocmd FileType go autocmd BufWritePre <buffer> :Fmt
augroup END

" }}}
" Refresh firefox on saving website related documents {{{
" Requires mozrepl firefox plugin
"autocmd BufWriteCmd *.html,*.css,*.gtpl,*.tt,*.tt2,*.js,*.mkdn
            "\:call Refresh_firefox()
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

" }}}
" Quick dot-file hacking mappings and stuff {{{

" open .vimrc in splitwindow
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vim/.vimrc<cr>
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/github/zsh-conf/.zsh_aliases<cr>
nnoremap <leader>ez <C-w><C-v><C-l>:e ~/github/zsh-conf/.zshrc<cr>

augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au BufWritePost .vimrc source $MYVIMRC
augroup END

" }}}
" zsh_alias folding {{{
augroup Zsh_alias
    au!
    autocmd FileType zsh setlocal foldmethod=expr foldexpr=GetZshAliasFold(v:lnum)
augroup END

" or maybe just use marks
function! GetZshAliasFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '0'
    endif

    if getline(a:lnum) =~? '\v^\s*#'
        if foldlevel(a:lnum-1) > 0
            return '1'
        endif
        return '>1'
    endif

    if foldlevel(a:lnum) < foldlevel(a:lnum-1) && getline(a:lnum) !~? '\v^\s*$'
        return '1'
    endif

    return '0'
endfunction
" }}}
" Tab navigation {{{

nnoremap <C-tab> gt
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>ct :tabclose<cr>

" }}}
" Help files {{{

augroup helpfiles
    au!
    autocmd FileType help,text setlocal textwidth=78
augroup END

" Align help tags all the way to the right                         *like this*
nnoremap <leader><tab> :call AlignTagToRight()<cr>
function! AlignTagToRight()
    let l:toSpace = &textwidth - strlen(getline('.')) +1
    let l:toReplace = substitute( getline('.') , '\s\*' , repeat(' ', l:toSpace) . '\*' , "")
    call setline( '.', l:toReplace)
endfunction

"}}}
" Abbrevations {{{

ab frk Freek Kalter
ab ccopy Copyright (c) 2013 Freek Kalter
ab cbsd Use of this source code is governed by the "Revised BSD License"
            \that can be found in the LICENSE file.
ab wbs kalteronline.org
ab === ===================================================================
            \===========

" }}}
" Text bubbling {{{

" Single lines in normal mode
nmap <C-Down> ddp
nmap <C-Up> ddkP

" use unimpaired but restore visual selection
vmap [e [egv
vmap ]e ]egv

" }}}

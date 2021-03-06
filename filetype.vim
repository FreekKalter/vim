" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
    au!
    au BufNewFile,BufRead *.tt set filetype=tt2html
    au BufNewFile,BufRead *.tt2 set filetype=tt2html

    au BufNewFile,BufRead *.less set filetype=css
    au BufNewFile,BufRead *.pl.tdy set filetype=perl

    au BufNewFile,BufRead *.go  set filetype=go
    au BufNewFile,BufRead *.ino set filetype=c

    au BufNewFile,BufRead .tmux.conf set filetype=tmux

    au BufNewFile,BufRead *.* call s:SetIptablesFiletype()

    " Set up puppet manifest and spec options
    au BufRead,BufNewFile *.pp set filetype=puppet
    au BufRead,BufNewFile *_spec.rb nmap <F8> :!rspec --color %<CR>

    au BufRead,BufNewFile *.md set filetype=markdown
    au BufRead,BufNewFile *.mkdn set filetype=markdown
augroup END
function! s:SetIptablesFiletype()
    if getline(1) =~ "^# Generated by iptables-save" || getline(1) =~ "^# Firewall configuration written by"
        setfiletype iptables
        set commentstring=#%s
    endif
endfunction

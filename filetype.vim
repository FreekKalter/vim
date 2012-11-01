" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
    au BufNewFile,BufRead *.tt set filetype=tt2html
    au BufNewFile,BufRead *.tt2 set filetype=tt2html

    au BufNewFile,BufRead *.less set filetype=css
    au BufNewFile,BufRead *.pl.tdy set filetype=perl

    au BufNewFile,BufRead *.go  set filetype=go
    
    au BufNewFile,BufRead .tmux.conf set filetype=tmux
augroup END

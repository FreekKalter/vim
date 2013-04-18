
function! NextColor( light )
    
    if exists('g:colors_name')
        if a:light == 1
            let l:current = index(g:lightColorCarousel, g:colors_name)
        else
            let l:current = index(g:darkColorCarousel, g:colors_name)
        endif
    else
        let l:current = 0
    endif

    let l:current += 1
    if a:light ==1
        if l:current >= len(g:lightColorCarousel)-1
            let l:current = 0
        endif
        execute 'colorscheme ' .  g:lightColorCarousel[l:current]
    else
        if l:current >= len(g:darkColorCarousel)-1
            let l:current = 0
        endif
        execute 'colorscheme ' .  g:darkColorCarousel[l:current]
    endif

    redraw
    echo g:colors_name
endfunction

noremap <F8> :call NextColor(1)<cr>
noremap <F9> :call NextColor(0)<cr>

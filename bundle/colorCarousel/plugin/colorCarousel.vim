
let s:currentLight = -1
let s:currentDark = -1
function! NextColor( method )
    if a:method == 'light'
        if s:currentLight == -1
            let s:currentLight = 0
        elseif index(g:lightColorCarousel, g:colors_name) != -1 " current color is light
            let s:currentLight += 1
        endif
    else
        if s:currentDark == -1
            let s:currentDark = 0
        elseif index(g:darkColorCarousel, g:colors_name) != -1 " current color is dark
            let s:currentDark += 1
        endif
    endif

    if a:method=='light'
        if s:currentLight > len(g:lightColorCarousel)-1
            let s:currentLight = 0
        endif
        execute 'colorscheme ' .  g:lightColorCarousel[s:currentLight]
    else
        if s:currentDark > len(g:darkColorCarousel)-1
            let s:currentDark = 0
        endif
        execute 'colorscheme ' .  g:darkColorCarousel[s:currentDark]
    endif

    redraw
    echo g:colors_name
endfunction

noremap <F8> :call NextColor('light')<cr>
noremap <F9> :call NextColor('dark')<cr>

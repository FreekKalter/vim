setlocal foldmethod=expr
setlocal foldexpr=GetGoFold(v:lnum)

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum+1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current +=1
    endwhile

    return -2
endfunction

function! PrevNonBlankLine(lnum)
    let numlines = line(0)
    let current = a:lnum-1

    while current >= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current -=1
    endwhile

    return -2
endfunction

function! GetGoFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent= IndentLevel(a:lnum)
    let next_indent= IndentLevel(NextNonBlankLine(a:lnum))
    let prev_indent= IndentLevel(PrevNonBlankLine(a:lnum))

    if next_indent == this_indent
        if prev_indent > this_indent && getline(a:lnum) =~? '\v^}'
            return prev_indent
        else
            return this_indent
        endif
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent 
        return '>' . next_indent 
    endif
endfunction

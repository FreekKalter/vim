setlocal foldmethod=expr
setlocal foldexpr=GetFoldOnFunction(v:lnum)

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

" Simple fold expression to fold functions and
" groups of vars,types and consts
function! GetFoldOnFunction(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        if IndentLevel(a:lnum-1) != 0 
            return '1'
        endif
        return '0'
    endif

    if getline(a:lnum) =~? '\v^(func|var|type|const)' || getline(a:lnum) =~? '\v^import'
        return ">1"
    endif

    if IndentLevel(a:lnum) == 0 && if getline(a:lnum) =~? '\v^(})|(\))$' && foldlevel(a:lnum-1) > 1
        return '1'
    endif

    if foldlevel(a:lnum-1) >= 1
        return '1'
    endif
endfunction

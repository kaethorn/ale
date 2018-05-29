" Author: Falko Schmidt <scf@panter.ch>

function! ale_linters#html#htmlint#Handle(buffer, lines) abort
    " Matches patterns like the following:
    " Closing tag mismatch for <div> detected at line 30, column 3.

    let l:pattern = '^\(.\+\) detected at line \(\d\+\), column \(\d*\)\.$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[2] + 0,
        \   'col': l:match[3] + 0,
        \   'text': l:match[1],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('html', {
\   'name': 'htmlint',
\   'executable': 'htmlint',
\   'command': 'htmlint %t',
\   'callback': 'ale_linters#html#htmlint#Handle',
\})

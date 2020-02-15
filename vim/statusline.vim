function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:currentmode={
    \ 'n'      : 'Normal ',
    \ 'no'     : 'N·Operator Pending ',
    \ 'v'      : 'Visual ',
    \ 'V'      : 'Visual·Line ',
    \ '\<C-V>' : 'Visual·Block ',
    \ 's'      : 'Select ',
    \ 'S'      : 'S·Line ',
    \ '\<C-S>' : 'S·Block ',
    \ 'i'      : 'Inset ',
    \ 'R'      : 'R ',
    \ 'Rv'     : 'V·Replace ',
    \ 'c'      : 'Command ',
    \ 'cv'     : 'Vim Ex ',
    \ 'ce'     : 'Ex ',
    \ 'r'      : 'Prompt ',
    \ 'rm'     : 'More ',
    \ 'r?'     : 'Confirm ',
    \ '!'      : 'Shell ',
    \ 't'      : 'Terminal '
    \}



" for colours: :so $VIMRUNTIME/syntax/hitest.vim
" https://learnvimscriptthehardway.stevelosh.com/chapters/17.html
" http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline'

set statusline=
set statusline+=%#Conceal#
set statusline+=%{toupper(g:currentmode[mode()])}
set statusline+=%#StatusLineTerm#
set statusline+=\ %t
set statusline+=\ \ 
set statusline+=
set statusline+=\ \ 
set statusline+=%#LineNr#
set statusline+=\ %F
set statusline+=%m
set statusline+=\ \ 
set statusline+=%h
set statusline+=%=
set statusline+=%#ErrorMsg#
set statusline+=%r      "read only flag
set statusline+=%#StatusLineTerm#
set statusline+=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l/%L:%c

hi TabLineFill ctermfg=DarkGray ctermbg=DarkGray
hi TabLine ctermfg=Black ctermbg=Gray
hi TabLineSel ctermfg=Black ctermbg=LightGreen

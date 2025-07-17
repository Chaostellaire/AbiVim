" SOURCED .vim file | modify to your likings
" to be effective just need to a source abinit.vim to vimrc.
"


" ****** .abi detection ******
au! BufRead,BufNewFile *.abi setfiletype abi

" ****** Activate autocomplete and syntax functions ******
syntax on
filetype plugin indent on

 
function! HighlightRepeats() range
  let wordCounts = {}
  let lineNum = a:firstline

  while lineNum <= a:lastline
    let lineText = getline(lineNum)

    " Skip empty lines and comments (starting with # or //)
    if lineText =~? '^\s*$' || lineText =~? '^\s*#' || lineText =~? '^\s*//'
      let lineNum += 1
      continue
    endif

    " Extract the first word
    let firstWord = matchstr(lineText, '^\s*\zs[A-Za-z]\+[0-9?:]*')

    if firstWord != ''
      let wordCounts[firstWord] = (has_key(wordCounts, firstWord) ? wordCounts[firstWord] : 0) + 1
    endif

    let lineNum += 1
  endwhile

  " Clear previous highlight group
  exe 'syn clear Repeat'

  " Highlight lines where first word is repeated
  for lineNum in range(a:firstline, a:lastline)
    let lineText = getline(lineNum)

    if lineText =~? '^\s*$' || lineText =~? '^\s*#' || lineText =~? '^\s*//'
      continue
    endif
    let firstWord = matchstr(lineText, '^\s*\zs[A-Za-z]\+[0-9?:]*')

    if has_key(wordCounts, firstWord) && wordCounts[firstWord] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
 

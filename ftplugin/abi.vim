" Restart syntax if in an abi file -- conflict with some colorschmes
augroup AbinitSyntax
  autocmd!
  autocmd ColorScheme * if &filetype == 'abi' | syntax enable | runtime! syntax/abi.vim | endif
augroup END
" Using only the dictionary created with the scrapper 
setlocal complete=k

" setting up the complete options
" longest selects the longest matching item first, 
" menuone shows menu even when there is only on item
" popup apply popup near item with options
setlocal completeopt=longest,menuone "minimal option for maximal compatibility
"setlocal completepopup=height:20,width:60
setlocal iskeyword+=-

" Global: abivim_help_vim
" -----------------------
" help window display mode : split [default], vsplit, tabnew, popup
if !has("g:abivim_help_win")
    let g:abivim_popup_help="split"
endif

if !has("g:abivim_error_on_save")
    let g:abivim_error_on_save=0
endif

let s:dict_location= expand("<sfile>:h") . "/../dict/"

function! CompleteABI(findstart, base)
    " let numberofvar=len(s:varnames)
    echo expand("<sfile>:h")
    let s:varnames=readfile(s:dict_location . "abivar.txt")
    let s:mnemonics=readfile(s:dict_location . "abimnemo.txt") 
    let s:numberofvar=len(s:varnames)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && (line[start - 1] =~ '\a' || line[start - 1] =~ '.' || line[start - 1] =~ '-')
            let start -= 1
        endwhile
        return start
    else
        " find classes matching "a:base"
        let res = [] 
        for m in range(s:numberofvar) 
            if s:varnames[m] =~ '^' . a:base
                let l:desc=string(s:mnemonics[m])
                call add(res, {"word": s:varnames[m], "menu": l:desc } )
            endif
        endfor
        return {"words": res}
    endif
endfun



setlocal completefunc=CompleteABI

" Repeat function to be call at first load + save + :HighlightRepeats  call
"
function! HighlightRepeats() range
  let wordCounts = {}
  let lineNum = a:firstline

  while lineNum <= a:lastline
    let lineText = getline(lineNum)

    if lineText =~? '^\s*#' || lineText =~? '^\s*!'
      let lineNum += 1
      continue
    endif
" input variables can contain _ in abinit
    let firstWord = matchstr(lineText, '^\s*\zs[A-Za-z_]\+[0-9?:+]*')

    if firstWord != ''
      let wordCounts[firstWord] = (has_key(wordCounts, firstWord) ? wordCounts[firstWord] : 0) + 1
    endif

    let lineNum += 1
  endwhile

  exe 'syn clear Repeat'

  " Highlight lines where first word is repeated
  for lineNum in range(a:firstline, a:lastline)
    let lineText = getline(lineNum)
    if lineText =~? '^\s*#' || lineText =~? '^\s*!'
      continue
    endif
    let firstWord = matchstr(lineText, '^\s*\zs[A-Za-z_]\+[0-9?:+]*')

    if has_key(wordCounts, firstWord) && wordCounts[firstWord] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

function! CheckInput()
    " Checks the current buffers input with the abinit --dry-run commands then
    " cleans up the repo
    " NOTE: Upgrading this command with capture and parsing of the file
    let abinitInputName = expand("%:p:r")
    " System command to hard reverting
    exec "!{ echo  " .. abinitInputName .. ".abi;echo tmp.abivim.abo;echo " .. abinitInputName .. "i;echo " .. abinitInputName .. "o;echo ; } | abinit --dry-run"
    " let outputCheck = system("abinit --dry-run", inputList)
    silent !rm tmp.abivim.abo
endfunction


command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
command! CheckInput call CheckInput()
command! GoToDef call abinit_function#GoToDef()
command! ShowDef call abinit_function#ShowDef()

nnoremap <C-]> :ShowDef

if g:abivim_error_on_save==1
    autocmd! BufReadPost,BufWritePost *.abi HighlightRepeats  
else
    autocmd! BufReadPost,BufWritePost
" TODO: Implement error when saving with syntax error
endif



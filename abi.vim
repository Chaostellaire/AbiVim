" Using only the dictionary created with the scrapper 
setlocal complete=k
setlocal dictionary+=$HOME/.vim/assets/abivar.txt

" setting up the complete options
" longest selects the longest matching item first, 
" menuone shows menu even when there is only on item
" popup apply popup near item with options
setlocal completeopt=longest,menuone "minimal option for maximal compatibility
"setlocal completepopup=height:20,width:60
setlocal iskeyword+=-


" trying custom function :
"source $HOME/.vim/assets/abivar.txt

let s:varnames=readfile(glob("PLACEHOLDER/assets/abivar.txt"))
let s:mnemonics=readfile(glob("PLACEHOLDER/.vim/assets/abimnemo.txt")) 
let b:numberofvar=len(s:varnames)

function! CompleteABI(findstart, base)
    " let numberofvar=len(s:varnames)
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
        for m in range(b:numberofvar) 
            if s:varnames[m] =~ '^' . a:base
                let l:desc=string(s:mnemonics[m])
                call add(res, {"word": s:varnames[m], "menu": l:desc } )
            endif
        endfor
        return {"words": res}
    endif
endfun



setlocal completefunc=CompleteABI







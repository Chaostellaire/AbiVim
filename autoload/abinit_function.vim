


function! abinit_function#GoToDef()
    " Open the website with var undercursor 
    let s:varname=matchstr(expand('<cword>'), '[A-Za-z_]*')
    if s:varname != ''
        let s:varnames=readfile(expand("<script>:p:h") .. "/../dict/abivar.txt")
        let s:vartypes=readfile(expand("<script>:p:h") .. "/../dict/abiset.txt")
        let m=0
        while m < len(s:vartypes)
            if s:varnames[m] =~ s:varname
                let s:url = 'https://docs.abinit.org/variables/' . s:vartypes[m] . '/#' . s:varname
                call netrw#BrowseX(s:url, netrw#CheckIfRemote())
                break
            else
                let m+=1
            endif
        endwhile 
        if m =~ len(s:vartypes)
            echom "No variable found in dictionnary named " . s:varname
        endif
    else
        echom "No text found"
    endif
endfun

"
"
"
"
"
" Harmonie Lebrun

let s:dict_location=expand("<sfile>:h") .. "/../dict/"

" abinit_function#GoToDefWeb
" --------------------------
" Open the Abinit Documentation website at the correct tag
" To do so, place the cursor on the keyword and it will launch
" the webbrowser with vim's build in features.
function! abinit_function#GoToDefWeb()
    " Open the website with var undercursor 
    let s:varname=matchstr(expand('<cword>'), '[A-Za-z_]*')
    if s:varname != ''
        let s:varnames=readfile(s:dict_location . "abivar.txt")
        let s:vartypes=readfile(s:dict_location . "abiset.txt")
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

" suppose that I know the path to the documentation locally
let g:documentation_path='/home/lebrunh/local/src/abinit-v10.4.7/abimkdocs/variables_abinit.py'

" abinit_function#ShowDef()
" -------------------------
" Show the defintion of the varaible under the cursor with the local
" documentation
function! abinit_function#ShowDef()
    let s:varname=matchstr(expand('<cword>'), '[A-Za-z_]*')
    if s:varname != ''
        " exe 'argument ' . l:docbufnr
        " let l:varname_line = search('abivarname="'.s:varname.'"', 'cn')
        " echom l:varname_line
        " exec 'Normal '.l:varname_line-1.'gg'
        " call setbufline("abivim_help_popup",1,getbufline(s:documentation,l:varname_line,l:last_line-1))
        " exec 'argument ' . l:helpbufnr


        "searchpair('(','',')','rW')
        "getbufline(buffname, lnum, end) -> Line list
        execute 'lvimgrep /abivarname="' . s:varname . '"/ ' . g:documentation_path
        let l:first_line=line('.')
        let l:last_line = searchpair('(','',')','Wn')-1
        let l:VarObject= getline(l:first_line,l:last_line) 

        $tabnew abivim_help
        setfiletype abi
        setlocal buftype=nofile bufhidden=wipe noswapfile
        call setline(1,l:VarObject)
        setlocal nomodifiable
    
        "normal zz
    endif
endfunction


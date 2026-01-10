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
" documentation. Creates a Popup with the information.
" TODO : Check if popup is available otherwise fallback to splitscreen vim < 802 has no popup
function! abinit_function#ShowDef()
    let s:varname=matchstr(expand('<cword>'), '[A-Za-z_]*')
    if s:varname != ''
        let l:docbufnr = bufadd(g:documentation_path)
        let s:helpbufnr = bufadd("abivim_help")
        execute 'lvimgrep /abivarname="' . s:varname . '"/ ' . g:documentation_path
        let l:first_line=line('.')
        let l:last_line = searchpair('(','',')','Wn')-1
        let l:VarObject= getline(l:first_line,l:last_line) 
        execute 'bd ' . l:docbufnr

        let l:VarObject = abinit_function#_ParseDoc(l:VarObject)
        call bufload(s:helpbufnr)
        call setbufline(s:helpbufnr,1,l:VarObject)
        if v:version > 801 && g:abivim_popup_help && has("popupwin")
            " Popup mode is compiled and user activated it
            call setbufvar(s:helpbufnr,'buftype','popup')
            call setbufvar(s:helpbufnr,'bufhidden','delete')
            call setbufvar(s:helpbufnr,'&filetype', 'abi')
            call popup_create(s:helpbufnr, {'line':'cursor+1','col':'cursor','pos':'topleft','moved':'any'})   
            " NOTE: still the popup wants to be saved smh 
        else
            " newtab or split
            " MISSING: vsplit and tabnew support
            split abivim_help
            setfiletype abi
            setlocal buftype=nofile bufhidden=wipe noswapfile
            setlocal nomod
        endif  
    endif
endfunction

" abinit_function#_ParseDoc()
" ---------------------------
" Parse the documentation 'Variable' object of the varaible_abinit.py file
" Function is not meant to be call by user
function! abinit_function#_ParseDoc(lines)
    " MISSING: Default value
    let l:lengthHelp = 80
    let l:outputLines=[]
    let l:line='' "current line
    for i in range(0,len(a:lines)-1)
        if a:lines[i] =~ 'abivarname='
            let l:name = substitute(a:lines[i],'\s\+abivarname="\([^"]*\)".*', '\=submatch(1)', '')
        elseif a:lines[i] =~ 'vartype='
            let l:type = substitute(a:lines[i],'\s\+vartype="\([^"]*\)".*', '\=submatch(1)', '')
        elseif a:lines[i] =~ 'version='
            let l:version = substitute(a:lines[i],'\s\+added_in_version="\([^"]*\)".*', '\=submatch(1)', '')
        elseif a:lines[i] =~ 'dimensions='
            let l:dim = substitute(a:lines[i],'\s\+dimensions="\?\[\?\([^"]*\)\]\?"\?,.*', '\=submatch(1)', '')
            let l:dim = substitute(l:dim, "'", '', 'g')
        elseif a:lines[i] =~ 'text='
            let l:currentidx = i+1
            break
        endif
    endfor 
    let l:line = l:name . ' {' . l:type . '} -- ' . l:dim
    let l:line .= repeat(' ', l:lengthHelp - strlen(l:line) - strlen(l:version) - 2) . '(' . l:version . ')'
    call add(l:outputLines, l:line)
    call add(l:outputLines, repeat('-', l:lengthHelp))
    while a:lines[l:currentidx] !~ '"""' && l:currentidx < len(a:lines)
        call add(l:outputLines, a:lines[l:currentidx])
        let l:currentidx+=1
    endwhile
    return l:outputLines
endfunction


   

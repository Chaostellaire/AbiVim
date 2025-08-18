" -----------------------------------------------------------------------
"  File: abivim.vim
"  Description: A vim plugin for Abinit ecosystem coloring
"  Author: H.Lebrun <harmonie.lebrun@cea.fr>
"  Source: https://github.com/chaostellaire/abivim
"  Last Modified: 18 Aug 2025
" ----------------------------------------------------------------------

" Enable .abi detection
au! BufRead,BufNewFile *.abi setfiletype abi

" Global Settings: {{{

" >Colors options

if !has("g:abivim_color_custom")
    let g:abivim_color_custom = false
endif

if !has("g:abivim_supercomment")
    let g:abivim_supercomment = true
endif

" }}}




" Colors Settings: {{{
" !PUSH AT THE END OF FILE!

" Checking first if we choosed Link, or custom colors :

if g:abivim_color_custom
" >>Custom colors


else
" >>Linkers

    if !has("g:abivim_link_basic")
        let g:abivim_link_basic = "Type"
    endif




endif

" }}}



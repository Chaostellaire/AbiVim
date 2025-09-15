" -----------------------------------------------------------------------
"  File: abivim.vim (filetype detect)
"  Description: compilation of abinit file type detection  
"  Author: H.Lebrun <harmonie.lebrun@cea.fr>
"  Source: https://github.com/chaostellaire/abivim
"  Last Modified: 15 Sep 2025
" ----------------------------------------------------------------------
" Enable .abi detection
au! BufRead,BufNewFile *.abi setfiletype abi
au! BufRead,BufNewFile *.abo setfiletype abo

